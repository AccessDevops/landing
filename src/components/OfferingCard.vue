<script setup lang="ts">
defineProps<{
  title: string
  subtitle: string
  description: string
  features: string[]
  highlighted?: boolean
}>()
</script>

<template>
  <div
    v-motion
    :whileHover="{ y: -8, scale: 1.02, transition: { duration: 300, ease: 'easeOut' } }"
    :class="[
      'border border-slate-200 rounded-xl p-10 hover:shadow-xl transition-all duration-300 flex flex-col h-full cursor-pointer',
      highlighted ? 'bg-blue-50 ring-2 ring-blue-600 ring-opacity-20' : 'bg-white',
    ]"
  >
    <div class="mb-6">
      <h3 class="text-2xl font-bold text-slate-900 mb-2">{{ title }}</h3>
      <p class="text-slate-600 font-medium">{{ subtitle }}</p>
    </div>
    <p class="text-slate-600 mb-8 leading-relaxed">{{ description }}</p>
    <ul class="space-y-4 mb-8 flex-grow">
      <li v-for="(feature, index) in features" :key="index" class="flex items-start gap-3">
        <svg
          class="w-5 h-5 text-blue-600 mt-0.5 flex-shrink-0"
          fill="none"
          stroke="currentColor"
          viewBox="0 0 24 24"
        >
          <path
            stroke-linecap="round"
            stroke-linejoin="round"
            stroke-width="2"
            d="M20 6 9 17l-5-5"
          />
        </svg>
        <span class="text-slate-700">{{ feature }}</span>
      </li>
    </ul>
    <a
      href="#comparison"
      class="text-blue-600 hover:text-blue-700 font-semibold flex items-center gap-2 mt-auto"
    >
      Learn More
      <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
        <path
          stroke-linecap="round"
          stroke-linejoin="round"
          stroke-width="2"
          d="M5 12h14m-7-7 7 7-7 7"
        />
      </svg>
    </a>
  </div>
</template>
