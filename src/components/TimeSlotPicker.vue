<script setup lang="ts">
import { ref, watch, computed } from 'vue'
import { useBookingApi } from '../composables/useBookingApi'
import { useAnalytics } from '../composables/useAnalytics'

const { trackBookingEvent } = useAnalytics()

const props = defineProps<{
  modelValue?: string
  selectedDate?: Date
}>()

const emit = defineEmits<{
  'update:modelValue': [time: string]
}>()

const { getAvailableSlots, isLoading: isLoadingSlots } = useBookingApi()

// Available slots from API
const availableSlots = ref<string[]>([])

// Fetch available slots when date changes
watch(
  () => props.selectedDate,
  async (newDate) => {
    if (!newDate) {
      availableSlots.value = []
      return
    }

    // Format date as YYYY-MM-DD
    const dateString = newDate.toISOString().split('T')[0]
    if (dateString) {
      const slots = await getAvailableSlots(dateString)
      availableSlots.value = slots
    }
  },
  { immediate: true }
)

// All possible time slots for display
const timeSlots = computed(() => {
  const slots = []
  for (let hour = 9; hour <= 17; hour++) {
    for (let minute = 0; minute < 60; minute += 30) {
      if (hour === 17 && minute > 0) break
      const timeString = `${hour.toString().padStart(2, '0')}:${minute.toString().padStart(2, '0')}`
      slots.push(timeString)
    }
  }
  return slots
})

const isSlotAvailable = (slot: string) => {
  return availableSlots.value.includes(slot)
}

const selectTimeSlot = (time: string) => {
  if (isSlotAvailable(time)) {
    emit('update:modelValue', time)
    // Track time slot selection
    trackBookingEvent('time_selected', {
      time,
      date: props.selectedDate?.toISOString().split('T')[0],
    })
  }
}

const formatTime = (time: string) => {
  const [hour, minute] = time.split(':')
  const hourNum = parseInt(hour || '0')
  const period = hourNum >= 12 ? 'PM' : 'AM'
  const displayHour = hourNum > 12 ? hourNum - 12 : hourNum === 0 ? 12 : hourNum
  return `${displayHour}:${minute || '00'} ${period}`
}
</script>

<template>
  <div class="bg-white rounded-xl border border-slate-200 p-6">
    <div class="mb-4">
      <h3 class="text-lg font-semibold text-slate-900">Select a time slot</h3>
      <p class="text-xs text-slate-500 mt-1">All times are in Paris timezone (CET/CEST)</p>
    </div>

    <div v-if="!selectedDate" class="text-center py-8 text-slate-500">
      <svg class="w-12 h-12 mx-auto mb-3 text-slate-300" fill="none" stroke="currentColor" viewBox="0 0 24 24">
        <path
          stroke-linecap="round"
          stroke-linejoin="round"
          stroke-width="2"
          d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"
        />
      </svg>
      <p class="text-sm">Please select a date first</p>
    </div>

    <div v-else>
      <div v-if="isLoadingSlots" class="text-center py-8">
        <div class="inline-block animate-spin rounded-full h-8 w-8 border-b-2 border-blue-600"></div>
        <p class="text-sm text-slate-500 mt-2">Loading available slots...</p>
      </div>
      <div v-else class="grid grid-cols-2 md:grid-cols-3 gap-3 max-h-[400px] overflow-y-auto pr-2">
        <button
          v-for="slot in timeSlots"
          :key="slot"
          @click="selectTimeSlot(slot)"
          :disabled="!isSlotAvailable(slot)"
          :class="[
            'px-4 py-3 rounded-lg text-sm font-medium transition-all border',
            modelValue === slot
              ? 'bg-blue-600 text-white border-blue-600'
              : isSlotAvailable(slot)
                ? 'bg-white border-slate-200 text-slate-700 hover:border-blue-300 hover:bg-blue-50'
                : 'bg-slate-100 border-slate-200 text-slate-400 cursor-not-allowed line-through',
          ]"
        >
          {{ formatTime(slot) }}
        </button>
      </div>
    </div>
  </div>
</template>
