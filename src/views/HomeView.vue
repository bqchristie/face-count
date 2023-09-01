<script>
import io from 'socket.io-client'

export default {
  data() {
    return {
      socket: null,
      messages: [],
      messageInput: ''
    }
  },
  mounted() {
    // Connect to the S}ocket.IO server
    this.socket = io('http://localhost:3000')
    // Listen for incoming messages
    this.socket.on('create-request', (message) => {
      // eslint-disable-next-line no-debugger
      debugger
      console.log(message)
    })
  }
}
</script>

<template>
  <main>
    <h1>Facecount Login</h1>
    <form>
      <label for="username">Username</label>
      <input name="username" type="text" />
      <button type="submit">Login</button>
    </form>
  </main>
</template>

<style scoped>
form {
  display: flex;
  flex-direction: column;
  gap: 0.3rem;
}
</style>
