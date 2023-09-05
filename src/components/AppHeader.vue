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
<style scoped>
header {
  display: flex;
  justify-content: space-between;
  max-width: 1280px;
  margin: auto;
  padding-left: 2em;
  padding-right: 2em;
  padding-top: 2em;
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
  cursor: pointer;
}
</style>
