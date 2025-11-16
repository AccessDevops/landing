<script setup lang="ts">
import { ref, computed } from 'vue'

const props = defineProps<{
  isOpen: boolean
  selectedDate?: Date
  selectedTime?: string
  isSubmitting?: boolean
}>()

const emit = defineEmits<{
  close: []
  submit: [data: { name: string; email: string; description: string }]
}>()

const form = ref({
  name: '',
  email: '',
  description: '',
})

const emailError = ref('')
const emailTouched = ref(false)

const formattedDate = computed(() => {
  if (!props.selectedDate) return ''
  return props.selectedDate.toLocaleDateString('en-US', {
    weekday: 'long',
    year: 'numeric',
    month: 'long',
    day: 'numeric',
  })
})

const formattedTime = computed(() => {
  if (!props.selectedTime) return ''
  const [hour, minute] = props.selectedTime.split(':')
  const hourNum = parseInt(hour || '0')
  const period = hourNum >= 12 ? 'PM' : 'AM'
  const displayHour = hourNum > 12 ? hourNum - 12 : hourNum === 0 ? 12 : hourNum
  return `${displayHour}:${minute || '00'} ${period}`
})

const validateEmail = (email: string): string => {
  if (!email) {
    return 'Email is required'
  }

  const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/
  if (!emailRegex.test(email)) {
    return 'Please enter a valid email address'
  }

  return ''
}

const handleEmailBlur = () => {
  emailTouched.value = true
  emailError.value = validateEmail(form.value.email)
}

const handleEmailInput = () => {
  if (emailTouched.value) {
    emailError.value = validateEmail(form.value.email)
  }
}

const isFormValid = computed(() => {
  return (
    form.value.name.trim() !== '' &&
    form.value.email.trim() !== '' &&
    validateEmail(form.value.email) === '' &&
    form.value.description.trim() !== ''
  )
})

const handleSubmit = () => {
  // Validate all fields before submitting
  emailTouched.value = true
  emailError.value = validateEmail(form.value.email)

  if (!isFormValid.value) {
    return
  }

  emit('submit', {
    name: form.value.name,
    email: form.value.email,
    description: form.value.description,
  })
  // Reset form
  form.value = {
    name: '',
    email: '',
    description: '',
  }
  emailError.value = ''
  emailTouched.value = false
}

const handleClose = () => {
  emit('close')
}

const handleBackdropClick = (e: MouseEvent) => {
  if (e.target === e.currentTarget) {
    handleClose()
  }
}
</script>

<template>
  <Teleport to="body">
    <Transition
      enter-active-class="transition-opacity duration-300"
      enter-from-class="opacity-0"
      enter-to-class="opacity-100"
      leave-active-class="transition-opacity duration-200"
      leave-from-class="opacity-100"
      leave-to-class="opacity-0"
    >
      <div
        v-if="isOpen"
        class="fixed inset-0 bg-slate-900/50 backdrop-blur-sm z-50 flex items-center justify-center p-4"
        @click="handleBackdropClick"
      >
        <Transition
          enter-active-class="transition-all duration-300"
          enter-from-class="opacity-0 scale-95"
          enter-to-class="opacity-100 scale-100"
          leave-active-class="transition-all duration-200"
          leave-from-class="opacity-100 scale-100"
          leave-to-class="opacity-0 scale-95"
        >
          <div
            v-if="isOpen"
            class="bg-white rounded-xl shadow-2xl max-w-md w-full max-h-[90vh] overflow-y-auto"
            @click.stop
          >
            <!-- Header -->
            <div class="sticky top-0 bg-white border-b border-slate-200 px-6 py-4 flex items-center justify-between">
              <h2 class="text-2xl font-bold text-slate-900">Confirm Booking</h2>
              <button
                @click="handleClose"
                class="p-2 rounded-lg hover:bg-slate-100 text-slate-500 hover:text-slate-700 transition-colors"
              >
                <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
                </svg>
              </button>
            </div>

            <!-- Body -->
            <div class="p-6">
              <!-- Selected Date & Time -->
              <div class="bg-blue-50 rounded-lg p-4 mb-6">
                <div class="flex items-center gap-3 mb-2">
                  <svg class="w-5 h-5 text-blue-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path
                      stroke-linecap="round"
                      stroke-linejoin="round"
                      stroke-width="2"
                      d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"
                    />
                  </svg>
                  <p class="text-sm font-semibold text-slate-900">{{ formattedDate }}</p>
                </div>
                <div class="flex items-center gap-3">
                  <svg class="w-5 h-5 text-blue-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path
                      stroke-linecap="round"
                      stroke-linejoin="round"
                      stroke-width="2"
                      d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"
                    />
                  </svg>
                  <p class="text-sm font-semibold text-slate-900">{{ formattedTime }} <span class="text-slate-500 font-normal">(Paris timezone, 15 minutes)</span></p>
                </div>
              </div>

              <!-- Form -->
              <form @submit.prevent="handleSubmit" class="space-y-4">
                <div>
                  <label for="name" class="block text-sm font-medium text-slate-700 mb-2">Full Name *</label>
                  <input
                    v-model="form.name"
                    type="text"
                    id="name"
                    required
                    class="w-full px-4 py-3 border border-slate-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-600 transition-shadow"
                    placeholder="John Doe"
                  />
                </div>

                <div>
                  <label for="email" class="block text-sm font-medium text-slate-700 mb-2">Email *</label>
                  <input
                    v-model="form.email"
                    type="email"
                    id="email"
                    required
                    @blur="handleEmailBlur"
                    @input="handleEmailInput"
                    :class="[
                      'w-full px-4 py-3 border rounded-lg focus:outline-none focus:ring-2 transition-all',
                      emailError && emailTouched
                        ? 'border-red-500 focus:ring-red-500'
                        : 'border-slate-300 focus:ring-blue-600'
                    ]"
                    placeholder="john@company.com"
                  />
                  <Transition
                    enter-active-class="transition-all duration-200"
                    enter-from-class="opacity-0 -translate-y-1"
                    enter-to-class="opacity-100 translate-y-0"
                    leave-active-class="transition-all duration-150"
                    leave-from-class="opacity-100 translate-y-0"
                    leave-to-class="opacity-0 -translate-y-1"
                  >
                    <p v-if="emailError && emailTouched" class="mt-2 text-sm text-red-600 flex items-center gap-1">
                      <svg class="w-4 h-4" fill="currentColor" viewBox="0 0 20 20">
                        <path fill-rule="evenodd" d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-7 4a1 1 0 11-2 0 1 1 0 012 0zm-1-9a1 1 0 00-1 1v4a1 1 0 102 0V6a1 1 0 00-1-1z" clip-rule="evenodd" />
                      </svg>
                      {{ emailError }}
                    </p>
                  </Transition>
                </div>

                <div>
                  <label for="description" class="block text-sm font-medium text-slate-700 mb-2"
                    >Brief Description *</label
                  >
                  <textarea
                    v-model="form.description"
                    id="description"
                    required
                    rows="4"
                    class="w-full px-4 py-3 border border-slate-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-600 resize-none transition-shadow"
                    placeholder="Tell us briefly about your infrastructure needs..."
                  ></textarea>
                </div>

                <div class="flex gap-3 pt-2">
                  <button
                    type="button"
                    @click="handleClose"
                    :disabled="isSubmitting"
                    class="flex-1 px-6 py-3 border border-slate-300 text-slate-700 font-semibold rounded-lg hover:bg-slate-50 transition-colors disabled:opacity-50 disabled:cursor-not-allowed"
                  >
                    Cancel
                  </button>
                  <button
                    type="submit"
                    :disabled="!isFormValid || isSubmitting"
                    :class="[
                      'flex-1 px-6 py-3 font-semibold rounded-lg transition-all flex items-center justify-center gap-2',
                      isFormValid && !isSubmitting
                        ? 'bg-blue-600 text-white hover:bg-blue-700 cursor-pointer'
                        : 'bg-slate-300 text-slate-500 cursor-not-allowed'
                    ]"
                  >
                    <span v-if="isSubmitting" class="inline-block animate-spin rounded-full h-4 w-4 border-b-2 border-white"></span>
                    <span>{{ isSubmitting ? 'Booking...' : 'Confirm Booking' }}</span>
                  </button>
                </div>
              </form>
            </div>
          </div>
        </Transition>
      </div>
    </Transition>
  </Teleport>
</template>
