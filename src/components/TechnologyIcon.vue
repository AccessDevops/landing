<script setup lang="ts">
defineProps<{
  name: string
  icon?: string
  size?: 'small' | 'large'
}>()
</script>

<template>
  <div class="flex flex-col items-center" :class="size === 'large' ? 'gap-3' : 'gap-2'">
    <div
      :class="[
        'bg-white rounded-lg flex items-center justify-center shadow-sm border border-slate-200',
        size === 'large' ? 'w-20 h-20' : 'w-16 h-16',
      ]"
    >
      <span :class="size === 'large' ? 'text-3xl' : 'text-2xl'">{{ icon || '⚙️' }}</span>
    </div>
    <span :class="['font-medium', size === 'large' ? 'font-semibold text-slate-900' : 'text-sm text-slate-700']">{{
      name
    }}</span>
  </div>
</template>
