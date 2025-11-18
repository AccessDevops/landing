<script setup lang="ts">
import TechnologyIcon from './TechnologyIcon.vue'

const corePartners = [
  { name: 'Google Cloud', icon: '☁️' },
  { name: 'Docker', icon: '🐋' },
]

const tools = [
  { name: 'GitLab', icon: '📦' },
  { name: 'GitHub', icon: '🐙' },
  { name: 'Jenkins', icon: '🔄' },
  { name: 'SonarQube', icon: '🔍' },
  { name: 'Grafana', icon: '📊' },
  { name: 'Ubuntu', icon: '🐧' },
  { name: 'Debian', icon: '🐚' },
  { name: 'OpenVPN', icon: '🔐' },
  { name: 'Bash', icon: '⌨️' },
]
</script>

<template>
  <section id="technology" class="py-20 px-6 bg-white" aria-labelledby="technology-heading">
    <div class="max-w-6xl mx-auto">
      <h2
        id="technology-heading"
        v-motion
        :initial="{ opacity: 0, y: 30 }"
        :visibleOnce="{ opacity: 1, y: 0, transition: { duration: 600, ease: 'easeOut' } }"
        class="text-4xl font-bold text-slate-900 mb-4 text-center"
      >
        Technology Stack
      </h2>
      <p
        v-motion
        :initial="{ opacity: 0, y: 30 }"
        :visibleOnce="{ opacity: 1, y: 0, transition: { duration: 600, delay: 100, ease: 'easeOut' } }"
        class="text-center text-slate-600 mb-16 text-lg"
      >
        We stand on the shoulders of giants
      </p>

      <div class="space-y-12">
        <!-- Core Infrastructure Partners -->
        <div>
          <h3
            v-motion
            :initial="{ opacity: 0, y: 30 }"
            :visibleOnce="{ opacity: 1, y: 0, transition: { duration: 600, delay: 200, ease: 'easeOut' } }"
            class="text-lg font-semibold text-slate-900 mb-6 text-center"
          >
            Our Core Infrastructure Partners
          </h3>
          <div class="flex flex-wrap gap-8 justify-center items-center">
            <div
              v-for="(partner, index) in corePartners"
              :key="partner.name"
              v-motion
              :initial="{ opacity: 0, scale: 0.8 }"
              :visibleOnce="{
                opacity: 1,
                scale: 1,
                transition: { duration: 600, delay: 400 + index * 100, ease: 'easeOut' },
              }"
            >
              <TechnologyIcon :name="partner.name" :icon="partner.icon" size="large" />
            </div>
          </div>
          <p
            v-motion
            :initial="{ opacity: 0, y: 30 }"
            :visibleOnce="{ opacity: 1, y: 0, transition: { duration: 600, delay: 600, ease: 'easeOut' } }"
            class="text-center text-slate-600 mt-6 text-sm"
          >
            5+ years of partnership with Google Cloud giving us access to cutting-edge
            infrastructure at competitive pricing.
          </p>
        </div>

        <!-- Tools & Platforms -->
        <div>
          <h3
            v-motion
            :initial="{ opacity: 0, y: 30 }"
            :visibleOnce="{ opacity: 1, y: 0, transition: { duration: 600, delay: 200, ease: 'easeOut' } }"
            class="text-lg font-semibold text-slate-900 mb-6 text-center"
          >
            Tools & Platforms
          </h3>
          <div class="flex flex-wrap gap-6 justify-center items-center">
            <div
              v-for="(tool, index) in tools"
              :key="tool.name"
              v-motion
              :initial="{ opacity: 0, scale: 0.8 }"
              :visibleOnce="{
                opacity: 1,
                scale: 1,
                transition: { duration: 600, delay: 400 + index * 50, ease: 'easeOut' },
              }"
            >
              <TechnologyIcon :name="tool.name" :icon="tool.icon" size="small" />
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>
</template>
