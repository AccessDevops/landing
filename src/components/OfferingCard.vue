<script setup lang="ts">
defineProps<{
  title: string
  subtitle: string
  description: string
  features: string[]
  variant?: 'gray' | 'blue' | 'orange' | 'green' | 'purple' | 'red' | 'yellow'
}>()
</script>

<template>
  <div
    v-motion
    :whileHover="{ y: -8, scale: 1.02, transition: { duration: 300, ease: 'easeOut' } }"
    class="group relative bg-white/80 backdrop-blur-sm rounded-2xl p-10 hover:shadow-2xl transition-all duration-500 flex flex-col h-full cursor-pointer border border-slate-100"
  >
    <!-- Gradient blur background -->
    <div
      :class="[
        'absolute inset-0 rounded-2xl blur-xl transition-opacity duration-300 opacity-10 group-hover:opacity-20',
        variant === 'green' ? 'bg-gradient-to-br from-green-400 to-green-600' :
        variant === 'gray' ? 'bg-gradient-to-br from-slate-400 to-slate-600' :
        variant === 'blue' ? 'bg-gradient-to-br from-blue-400 to-blue-600' :
        variant === 'orange' ? 'bg-gradient-to-br from-orange-400 to-orange-600' :
        variant === 'purple' ? 'bg-gradient-to-br from-purple-400 to-purple-600' :
        variant === 'red' ? 'bg-gradient-to-br from-red-400 to-red-600' :
        variant === 'yellow' ? 'bg-gradient-to-br from-yellow-400 to-yellow-600' :
        'bg-gradient-to-br from-slate-300 to-slate-500',
      ]"
    ></div>

    <!-- Content -->
    <div class="relative flex flex-col h-full">
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
  </div>
</template>
