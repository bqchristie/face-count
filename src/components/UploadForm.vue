<template>
  <div class="input-area">
    <h2>Submit an image for processing:</h2>
    <div class="form">
      <input type="file" @change="uploadFile" ref="file" />
      <input type="text" v-model="name" placeholder="enter a name " @keyup="validateName" />
      <button @click="onClickSubmitFile">Upload!</button>
    </div>
  </div>
</template>
<script>
export default {
  name: 'UploadForm',
  props: ['isNameUnique'],
  data() {
    return {
      uploadFile: null,
      name: null,
      debouncedCheck: null
    }
  },
  watch: {
    isNameUnique(newval) {
      console.log('NU: ' + newval)
    }
  },
  methods: {
    onClickSubmitFile() {
      this.Images = this.$refs.file.files[0]
      this.$emit('submit-file', this.Images)
    },
    validateName() {
      // debounce the keyup event for checking name uniqueness
      clearTimeout(this.debouncedCheck)
      this.debouncedCheck = setTimeout(() => {
        console.log(this.name)
        this.$emit('validate-name', this.name)
      }, 500)
    }
  }
}
</script>
<style scoped>
.form {
  display: flex;
  flex-direction: column;
  align-items: center;
}
</style>
