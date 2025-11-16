import { ref } from 'vue'
import { defineStore } from 'pinia'

export interface ContactForm {
  name: string
  email: string
  company: string
  message: string
}

export const useContactStore = defineStore('contact', () => {
  const submissions = ref<ContactForm[]>([])
  const isSubmitting = ref(false)
  const lastSubmissionSuccess = ref(false)

  function submitForm(form: ContactForm) {
    isSubmitting.value = true

    // Simulate API call
    setTimeout(() => {
      submissions.value.push({ ...form })
      isSubmitting.value = false
      lastSubmissionSuccess.value = true

      // Show success message in console (in production, this would be a real API call)
      console.log('Form submitted successfully:', form)

      // Reset success message after 3 seconds
      setTimeout(() => {
        lastSubmissionSuccess.value = false
      }, 3000)
    }, 500)
  }

  return {
    submissions,
    isSubmitting,
    lastSubmissionSuccess,
    submitForm,
  }
})
