<script setup lang="ts">
defineProps<{
  title: string
  value: string
}>()
</script>

<template>
  <div class="bg-white rounded-xl p-8 border border-slate-200 text-center hover:shadow-md transition-shadow">
    <slot name="icon" />
    <h3 class="font-semibold text-slate-900 mb-2">{{ title }}</h3>
    <p class="text-slate-600">{{ value }}</p>
  </div>
</template>
