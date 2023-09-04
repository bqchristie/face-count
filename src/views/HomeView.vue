<script>
import io from 'socket.io-client'
import Modal from '@/components/Modal.vue'
import axios from 'axios'

const LOGIN_URL = 'http://localhost:3000/api/v1/auth/login'
export default {
  components: {
    Modal
  },
  data() {
    return {
      username: null,
      isAuthenticated: false,
      user: null,
      socket: null,
      requests: [],
      config: {}
    }
  },
  mounted() {
    // Connect to the S}ocket.IO server
    this.socket = io('http://localhost:3000')
    // Listen for incoming messages
    this.socket.on('request-created', (request) => {
      this.requests.push(request)
    })
    this.socket.on('request-updated', (request) => {
      const idx = this.requests.findIndex((obj) => obj.id === request.id)
      if (idx !== -1) {
        // Replace the object at the found index with the new object
        this.requests[idx] = request
        console.log('Object updated successfully:')
      } else {
        console.log('Object with the specified ID not found.')
      }
      console.log(request)
    })
    this.socket.on('session-invalid', () => {
      // eslint-disable-next-line no-debugger
      this.isAuthenticated = false
    })
  },
  computed: {
    empty() {
      return !this.requests || this.requests.length === 0
    }
  },
  methods: {
    async login() {
      const payload = {
        username: this.username
      }
      const response = await axios.post(LOGIN_URL, payload)
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
      const response = await axios.get('http://localhost:3000/api/v1/request', this.config)
      this.requests = response.data
    },

    async deleteRequest(id) {
      await axios.delete(`http://localhost:3000/api/v1/request/${id}`, this.config)
      this.requests = this.requests.filter((obj) => obj.id !== id)
    },

    uploadFile() {
      this.Images = this.$refs.file.files[0]
    },
    submitFile() {
      const formData = new FormData()
      formData.append('image', this.Images)
      formData.append('name', this.Images.name)
      const headers = {
        'Content-Type': 'multipart/form-data',
        Authorization: `Bearer ${this.user.token}`
      }
      axios.post('http://localhost:3000/api/v1/request', formData, { headers }).then((res) => {
        res.data.files // binary representation of the file
        res.status // HTTP status
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
      <h1>Facecount Login</h1>
      <div class="login">
        <label for="username">Username</label>
        <input name="username" v-model="username" type="text" />
        <button type="submit" @click="login()">Login</button>
      </div>
    </Modal>
    <div v-if="isAuthenticated">
      <header>
        <div>
          <h1>Facecount</h1>
          <h3 v-if="isAuthenticated">Welcome, {{ user.username }}</h3>
        </div>
        <div>
          <a @click="logout()" class="logout-button">
            <div class="material-symbols-outlined">logout</div>
            <div>Logout</div>
          </a>
        </div>
      </header>
      <div class="app">
        <div class="input-area">
          <h2>Submit an image for processing:</h2>
          <div>
            <div>
              <input type="file" @change="uploadFile" ref="file" />
              <button @click="submitFile">Upload!</button>
            </div>
          </div>
        </div>
        <div class="data-area">
          <h2>Your Requests:</h2>
          <div v-if="empty">
            <p>No requests yet.</p>
          </div>
          <table v-if="!empty">
            <thead>
              <tr>
                <th>id</th>
                <th>name</th>
                <th>status</th>
                <th>created</th>
                <th>updated</th>
                <th>Face Count</th>
                <th></th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="request in requests" :key="request.id">
                <td>{{ request.id }}</td>
                <td>{{ request.name }}</td>
                <td class="status">
                  {{ request.Status.toUpperCase() }}
                  <span
                    v-if="request.Status !== 'complete'"
                    class="material-symbols-outlined incomplete"
                  >
                    sync
                  </span>
                  <span
                    v-if="request.Status === 'complete'"
                    class="material-symbols-outlined complete"
                  >
                    check
                  </span>
                </td>
                <td>{{ request.createdAt }}</td>
                <td>{{ request.updatedAt || '-' }}</td>
                <td class="number">{{ request.faceCount || '-' }}</td>
                <td>
                  <a href="#" @click="deleteRequest(request.id)"
                    ><span class="material-symbols-outlined"> delete </span></a
                  >
                </td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>
    </div>
  </main>
</template>

<style scoped></style>
