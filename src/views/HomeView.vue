<script setup></script>

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
