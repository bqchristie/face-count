<template>
  <div class="input-area">
    <h2>Submit an image for processing:</h2>
    <div class="form">
      <div class="add-photo" @click="() => this.$refs?.file?.click()">
        <span class="material-symbols-outlined"> add_circle </span>
        <div>
          <h3>Select image</h3>
          <h5>{{ selectedFile?.name || 'No file chosen' }}</h5>
        </div>
      </div>
      <input type="file" @change="handleFileChange" ref="file" hidden />
      <input
        type="text"
        v-model="name"
        class="flex-me"
        placeholder="enter a name "
        @keyup="validateName"
      />
      <a href="#" @click="onClickSubmitFile">
        <span class="material-symbols-outlined"> cloud_upload </span>
      </a>
    </div>
    <p>{{ validationMessage }}</p>
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
      debouncedCheck: null,
      selectedFile: null
    }
  },
  computed: {
    isValid() {
      return this.name && this.isNameUnique && this.$refs?.file?.files[0]
    },
    validationMessage() {
      if (!this.name && !this.selectedFile) return 'To get started select an image for processing.'
      if (!this.isNameUnique) return 'This name is already in use. Please choose another.'
      if (!this.name) return 'Please enter a name for the image.'
      if (!this.selectedFile) return 'Please select an image for processing.'
      return 'Click the upload button to submit your image for processing.'
    }
  },
  methods: {
    clear() {
      this.name = null
      this.selectedFile = null
    },
    onClickSubmitFile() {
      this.Images = this.$refs.file.files[0]
      this.$emit('submit-file', this.Images)
      this.clear()
    },
    handleFileChange() {
      this.selectedFile = this.$refs.file.files[0]
      //Use the file name as the default name
      if (!this.name) {
        this.name = this.selectedFile.name
      }
    },
    validateName() {
      // debounce the keyup event for checking name uniqueness
      clearTimeout(this.debouncedCheck)
      this.debouncedCheck = setTimeout(() => {
        this.$emit('validate-name', this.name)
      }, 500)
    }
  }
}
</script>
<style scoped>
.form {
  display: flex;
  flex-direction: row;
  justify-content: space-between;
  align-items: center;
  gap: 1rem;
}

.add-photo {
  width: 25%;
  display: flex;
  align-items: center;
  gap: 1rem;
  border: 1px dashed #ccc;
  padding: 0.4rem;
  border-radius: 0.5rem;
  cursor: pointer;
}

.flex-me {
  flex: 1;
}
.add-photo:hover {
  cursor: pointer;
}

.add-photo span {
  font-size: 2em;
  color: #ccc;
}

.input-area a {
  border-radius: 50%;
  border: none;
  width: 4em;
  height: 4rem;
  background-color: green;
  color: white;
  display: flex;
  justify-content: center;
  align-items: center;
  text-decoration: none;
}
</style>
