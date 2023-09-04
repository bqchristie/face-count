<template>
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
            <div v-if="request.Status !== 'complete'" class="material-symbols-outlined incomplete">
              sync
            </div>
            <div v-if="request.Status === 'complete'" class="material-symbols-outlined complete">
              check
            </div>
          </td>
          <td>{{ request.createdAt }}</td>
          <td>{{ request.updatedAt || '-' }}</td>
          <td class="number">{{ request.faceCount || '-' }}</td>
          <td>
            <a href="#" @click="onClickDeleteRequest(request.id)"
              ><span class="material-symbols-outlined"> delete </span></a
            >
          </td>
        </tr>
      </tbody>
    </table>
  </div>
</template>
<script>
export default {
  name: 'RequestData',
  props: {
    requests: {}
  },
  computed: {
    empty() {
      return !this.requests || this.requests.length === 0
    }
  },
  methods: {
    onClickDeleteRequest(id) {
      this.$emit('delete-request', id)
    }
  }
}
</script>
<style scoped>
td.status {
  display: flex;
  width: 150px;
  justify-content: space-between;
  align-items: center;
}
</style>
