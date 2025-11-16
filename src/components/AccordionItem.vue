<script setup lang="ts">
import { ref } from 'vue'

defineProps<{
  question: string
  answer?: string
}>()

const isOpen = ref(false)
</script>

<template>
  <div class="border border-slate-200 rounded-lg overflow-hidden">
    <button
      @click="isOpen = !isOpen"
      class="w-full flex items-center justify-between p-6 hover:bg-white transition-colors"
    >
      <h3 class="text-xl font-bold text-slate-900 text-left">{{ question }}</h3>
      <span
        :class="[
          'text-blue-600 font-bold text-2xl transition-transform',
          isOpen ? 'rotate-180' : '',
        ]"
        >▼</span
      >
    </button>
    <div v-if="isOpen && answer" class="px-6 py-4 bg-white border-t border-slate-200">
      <p class="text-slate-700 leading-relaxed">{{ answer }}</p>
    </div>
  </div>
</template>
