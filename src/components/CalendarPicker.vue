<script setup lang="ts">
import { ref, computed } from 'vue'
import { useAnalytics } from '../composables/useAnalytics'

const { trackBookingEvent } = useAnalytics()

const props = defineProps<{
  modelValue?: Date
}>()

const emit = defineEmits<{
  'update:modelValue': [date: Date]
}>()

const currentDate = new Date()
const currentMonth = ref(new Date(currentDate.getFullYear(), currentDate.getMonth(), 1))

const selectedDate = computed({
  get: () => props.modelValue,
  set: (value) => {
    if (value) emit('update:modelValue', value)
  },
})

const monthNames = [
  'January',
  'February',
  'March',
  'April',
  'May',
  'June',
  'July',
  'August',
  'September',
  'October',
  'November',
  'December',
]

const daysInMonth = computed(() => {
  const year = currentMonth.value.getFullYear()
  const month = currentMonth.value.getMonth()
  return new Date(year, month + 1, 0).getDate()
})

const firstDayOfMonth = computed(() => {
  return currentMonth.value.getDay()
})

const calendarDays = computed(() => {
  const days = []
  const year = currentMonth.value.getFullYear()
  const month = currentMonth.value.getMonth()

  // Add empty slots for days before the first day of month
  for (let i = 0; i < firstDayOfMonth.value; i++) {
    days.push(null)
  }

  // Add days of the month
  for (let day = 1; day <= daysInMonth.value; day++) {
    days.push(new Date(year, month, day))
  }

  return days
})

const isToday = (date: Date | null) => {
  if (!date) return false
  const today = new Date()
  return (
    date.getDate() === today.getDate() &&
    date.getMonth() === today.getMonth() &&
    date.getFullYear() === today.getFullYear()
  )
}

const isSelected = (date: Date | null) => {
  if (!date || !selectedDate.value) return false
  return (
    date.getDate() === selectedDate.value.getDate() &&
    date.getMonth() === selectedDate.value.getMonth() &&
    date.getFullYear() === selectedDate.value.getFullYear()
  )
}

const isPast = (date: Date | null) => {
  if (!date) return false
  const today = new Date()
  today.setHours(0, 0, 0, 0)
  const compareDate = new Date(date)
  compareDate.setHours(0, 0, 0, 0)
  return compareDate < today
}

const isWeekend = (date: Date | null) => {
  if (!date) return false
  const day = date.getDay()
  return day === 0 || day === 6 // Sunday or Saturday
}

const selectDate = (date: Date | null) => {
  if (!date || isPast(date) || isWeekend(date)) return
  selectedDate.value = date
  // Track date selection
  trackBookingEvent('date_selected', {
    date: date.toISOString().split('T')[0],
  })
}

const previousMonth = () => {
  currentMonth.value = new Date(currentMonth.value.getFullYear(), currentMonth.value.getMonth() - 1, 1)
}

const nextMonth = () => {
  currentMonth.value = new Date(currentMonth.value.getFullYear(), currentMonth.value.getMonth() + 1, 1)
}

const canGoPrevious = computed(() => {
  const prevMonth = new Date(currentMonth.value.getFullYear(), currentMonth.value.getMonth() - 1, 1)
  const today = new Date()
  return prevMonth >= new Date(today.getFullYear(), today.getMonth(), 1)
})
</script>

<template>
  <div class="bg-white rounded-xl border border-slate-200 p-6">
    <!-- Month Navigation -->
    <div class="flex items-center justify-between mb-6">
      <button
        @click="previousMonth"
        :disabled="!canGoPrevious"
        :class="[
          'p-2 rounded-lg transition-colors',
          canGoPrevious ? 'hover:bg-slate-100 text-slate-700' : 'text-slate-300 cursor-not-allowed',
        ]"
      >
        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 19l-7-7 7-7" />
        </svg>
      </button>

      <h3 class="text-lg font-semibold text-slate-900">
        {{ monthNames[currentMonth.getMonth()] }} {{ currentMonth.getFullYear() }}
      </h3>

      <button @click="nextMonth" class="p-2 rounded-lg hover:bg-slate-100 text-slate-700 transition-colors">
        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7" />
        </svg>
      </button>
    </div>

    <!-- Days of Week -->
    <div class="grid grid-cols-7 gap-2 mb-2">
      <div
        v-for="day in ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat']"
        :key="day"
        class="text-center text-sm font-medium text-slate-600 py-2"
      >
        {{ day }}
      </div>
    </div>

    <!-- Calendar Grid -->
    <div class="grid grid-cols-7 gap-2">
      <button
        v-for="(date, index) in calendarDays"
        :key="index"
        @click="selectDate(date)"
        :disabled="!date || isPast(date) || isWeekend(date)"
        :class="[
          'aspect-square flex items-center justify-center rounded-lg text-sm font-medium transition-all',
          !date && 'invisible',
          date && !isPast(date) && !isWeekend(date) && !isSelected(date) && 'hover:bg-slate-100 text-slate-700',
          date && (isPast(date) || isWeekend(date)) && 'text-slate-300 cursor-not-allowed',
          date && isToday(date) && !isSelected(date) && 'ring-2 ring-blue-200',
          date && isSelected(date) && 'bg-blue-600 text-white hover:bg-blue-700',
        ]"
      >
        {{ date?.getDate() }}
      </button>
    </div>
  </div>
</template>
