<template>
  <h1>Facecount Login</h1>
  <div class="login">
    <label for="username">Username</label>
    <input name="username" v-model="username" type="text" />
    <button type="submit" @click="onClickLogin()">Login</button>
  </div>
</template>
<script>
export default {
  name: 'LoginForm',
  data() {
    return {
      username: null
    }
  },
  methods: {
    onClickLogin() {
      this.$emit('login', this.username)
    }
  }
}
</script>
