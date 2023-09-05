<template>
  <div>
    <h2>Requests Summary</h2>
    <table>
      <thead>
        <tr>
          <th>Name</th>
          <th>Image Count</th>
          <th>Face Count</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="(item, name) in viewData" :key="name">
          <td>{{ name }}</td>
          <td>{{ item.imageCount }}</td>
          <td>{{ item.faceCount }}</td>
        </tr>
      </tbody>
    </table>
  </div>
</template>
<script>
export default {
  name: 'RequestSummary',
  props: {
    requests: []
  },
  data() {
    return {
      viewData: []
    }
  },
  watch: {
    requests(data) {
      const summary = data.reduce((acc, row) => {
        const { user, faceCount } = row

        if (Object.hasOwn(acc, user.username)) {
          acc[user.username].imageCount++
          acc[user.username].faceCount += faceCount
        } else {
          acc[user.username] = {
            imageCount: 1,
            faceCount
          }
        }
        return acc
      }, {})

      this.viewData = summary
    }
  }
}
</script>
