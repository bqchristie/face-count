<template>
  <h1>Facecount Login</h1>
  <div class="login">
    <label for="username">Please enter your username.</label>
    <input name="username" v-model="username" type="text" />
    <p>
      NOTE: This is just a demo. All usernames will work. If the user does not exist a new one will
      be created. <strong>To login as admin use the username: "admin".</strong>
    </p>
    <div class="buttons">
      <button type="submit" @click="onClickLogin()">Login</button>
    </div>
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
<style scoped>
.login {
  display: flex;
  flex-direction: column;
}
.buttons {
  display: flex;
  justify-content: flex-end;
  margin-top: 1em;
}
p {
  font-size: 0.8rem;
  color: var(--vt-c-text-light-1);
  width: 270px;
  margin: auto;
}
p strong {
  font-weight: bold;
}
</style>
