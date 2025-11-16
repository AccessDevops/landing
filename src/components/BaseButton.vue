<script setup lang="ts">
defineProps<{
  variant?: 'primary' | 'link'
  type?: 'button' | 'submit'
  fullWidth?: boolean
}>()
</script>

<template>
  <button
    :type="type || 'button'"
    :class="[
      'font-semibold rounded-lg transition-colors',
      variant === 'link'
        ? 'text-blue-600 hover:text-blue-700 inline-flex items-center gap-2'
        : 'bg-blue-600 hover:bg-blue-700 text-white px-8 py-3',
      fullWidth ? 'w-full' : '',
    ]"
  >
    <slot />
  </button>
</template>
