<script>
import io from 'socket.io-client'
import Modal from '@/components/Modal.vue'
import axios from 'axios'
import AppHeader from '@/components/AppHeader.vue'
import LoginForm from '@/components/LoginForm.vue'
import UploadForm from '@/components/UploadForm.vue'
import RequestData from '@/components/RequestData.vue'
import RequestSummary from '@/components/RequestSummary.vue'

const BASE_URL = `http://localhost:3000`
const API_BASE_URL = `${BASE_URL}/api/v1`
const LOGIN_URL = `${API_BASE_URL}/auth/login`
const REQUEST_URL = `${API_BASE_URL}/request`

export default {
  components: {
    RequestSummary,
    RequestData,
    UploadForm,
    LoginForm,
    AppHeader,
    Modal
  },
  data() {
    return {
      username: null,
      isAuthenticated: false,
      isNameUnique: false,
      user: null,
      socket: null,
      requests: [],
      config: {}
    }
  },
  mounted() {
    this.socket = this.initSocket()
  },

  methods: {
    async login(username) {
      const response = await axios.post(LOGIN_URL, { username })
      this.user = response.data.user
      this.isAuthenticated = true
      this.config = {
        headers: {
          Authorization: `Bearer ${this.user.token}`
        }
      }
      await this.loadRequests()
    },
    async loadRequests() {
      const response = await axios.get(REQUEST_URL, this.config)
      this.requests = response.data
    },
    async deleteRequest(id) {
      await axios.delete(`${REQUEST_URL}/${id}`, this.config)
    },
    async submitFile(data) {
      const { image, name } = data
      const formData = new FormData()
      formData.append('image', image)
      formData.append('fileName', image.name)
      formData.append('name', name)
      const headers = { ...this.config.headers, 'Content-Type': 'multipart/form-data' }
      axios.post(REQUEST_URL, formData, { headers }).then((res) => {
        res.data.files // binary representation of the file
        res.status // HTTP status
      })
    },
    async checkNameUnique(name) {
      const response = await axios.get(`${REQUEST_URL}?name=${name}`, this.config)
      this.isNameUnique = response.data.length === 0
    },
    initSocket() {
      this.socket = io(BASE_URL)
      this.socket.on('request-created', (request) => {
        this.requests.push(request)
      })
      this.socket.on('request-updated', (request) => {
        const idx = this.requests.findIndex((obj) => obj.id === request.id)
        if (idx !== -1) {
          this.requests[idx] = request
        }
      })
      this.socket.on('request-deleted', (request) => {
        this.requests = this.requests.filter((obj) => obj.id !== request.id)
      })
      this.socket.on('session-invalid', () => {
        this.isAuthenticated = false
      })
    },

    logout() {
      this.isAuthenticated = false
      this.user = null
      this.requests = []
    }
  }
}
</script>

<template>
  <main>
    <Modal v-if="!isAuthenticated">
      <LoginForm @login="login" />
    </Modal>
    <div v-if="isAuthenticated">
      <AppHeader :is-authenticated="isAuthenticated" :user="user" @logout="logout" />
      <div class="app" v-if="!user.isAdmin">
        <UploadForm
          @submit-file="submitFile"
          :is-name-unique="isNameUnique"
          @validate-name="checkNameUnique"
        />
        <RequestData @delete-request="deleteRequest" :requests="requests" />
      </div>
      <div class="app" v-if="user.isAdmin">
        <RequestSummary :requests="requests" />
      </div>
    </div>
  </main>
</template>

<style scoped>
.app {
  display: flex;
  flex-direction: column;
  gap: 2rem;
  max-width: 1280px;
  margin: 0 auto;
  padding: 2rem;
  font-weight: normal;
}
</style>
