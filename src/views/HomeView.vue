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
    this.socket.on('request-created', (message) => {
      // eslint-disable-next-line no-debugger
      console.log(message)
    })
    this.socket.on('request-updated', (message) => {
      // eslint-disable-next-line no-debugger
      console.log(message)
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
    <Modal v-if="!isAuthenticated" @close="hideModal">
      <h1>Facecount Login</h1>
      <div class="login">
        <label for="username">Username</label>
        <input name="username" v-model="username" type="text" />
        <button type="submit" @click="login()">Login</button>
      </div>
      <h2>{{ username }}</h2>
    </Modal>
    <div>
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
            <input type="file" />
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
                <td>
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
                <td>{{ request.faceCount || '-' }}</td>
                <td><span class="material-symbols-outlined"> delete </span></td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>
    </div>
  </main>
</template>

<style scoped>
.login {
  display: flex;
  flex-direction: column;
  gap: 0.3rem;
}
header {
  display: flex;
  justify-content: space-between;
  max-width: 1280px;
  margin: auto;
  padding-left: 2em;
  padding-right: 2em;
  padding-top: 2em;
}
h2 {
  margin-bottom: 0.3em;
}
table {
  width: 100%;
}
tr:hover {
  background-color: rgba(0, 0, 0, 0.1);
  cursor: pointer;
}
th {
  text-align: left;
  text-transform: capitalize;
  font-weight: bold;
}
td {
  //display: flex;
  //align-items: center;
}
span.incomplete {
  animation-name: rotate;
  animation-duration: 5s;
  animation-iteration-count: infinite;
  animation-timing-function: linear;
  color: orange;
  font-size: 1.2em;
}

span.complete {
  color: seagreen;
}

@keyframes rotate {
  from {
    transform: rotate(-360deg);
  }
  to {
    transform: rotate(360deg);
  }
}

.app {
  display: flex;
  flex-direction: column;
  gap: 2rem;
  max-width: 1280px;
  margin: 0 auto;
  padding: 2rem;
  font-weight: normal;
}

.logout-button {
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  border-radius: 50%;
  padding: 1em;
}

.logout-button:hover {
  background-color: rgba(0, 0, 0, 0.1);
  pointer: cursor;
}
</style>
