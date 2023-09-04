<template>
  <header>
    <div>
      <h1>Facecount</h1>
      <h3 v-if="isAuthenticated">Welcome, {{ user.username }}</h3>
    </div>
    <div>
      <a @click="onClickLogout" class="logout-button">
        <div class="material-symbols-outlined">logout</div>
        <div>Logout</div>
      </a>
    </div>
  </header>
</template>
<script>
export default {
  name: 'AppHeader',
  props: {
    isAuthenticated: {},
    user: {}
  },
  methods: {
    onClickLogout() {
      this.$emit('logout')
    }
  }
}
</script>
