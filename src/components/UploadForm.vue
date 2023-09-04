<template>
  <div class="input-area">
    <h2>Submit an image for processing:</h2>
    <div>
      <div>
        <input type="file" @change="uploadFile" ref="file" />
        <input type="text" v-model="name" placeholder="enter a name " />
        <button @click="onClickSubmitFile">Upload!</button>
      </div>
    </div>
  </div>
</template>
<script>
export default {
  name: 'UploadForm',
  data() {
    return {
      uploadFile: null,
      name: null
    }
  },
  methods: {
    onClickSubmitFile() {
      this.Images = this.$refs.file.files[0]
      this.$emit('submit-file', this.Images)
    }
  }
}
</script>
