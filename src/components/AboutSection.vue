<script setup lang="ts">
const locations = ['France', 'Spain', 'Canada', 'Colombia', 'Japan']

const coverage = [
  { icon: '🌍', label: 'Europe' },
  { icon: '🌎', label: 'North & South America' },
  { icon: '🌏', label: 'Asia' },
  { icon: '✈️', label: '24/7 Worldwide Support' },
]
</script>

<template>
  <section id="about" class="py-20 px-6 bg-white" aria-labelledby="about-heading">
    <div class="max-w-4xl mx-auto">
      <h2
        id="about-heading"
        v-motion
        :initial="{ opacity: 0, y: 30 }"
        :visibleOnce="{ opacity: 1, y: 0, transition: { duration: 600, ease: 'easeOut' } }"
        class="text-4xl font-bold text-slate-900 mb-12 text-center"
      >
        About Us
      </h2>

      <div
        v-motion
        :initial="{ opacity: 0, y: 30 }"
        :visibleOnce="{ opacity: 1, y: 0, transition: { duration: 600, delay: 200, ease: 'easeOut' } }"
        class="bg-white rounded-xl p-10 mb-12"
      >
        <p class="text-slate-700 leading-relaxed mb-8 text-lg">
          With over 500 customers and 1000+ server instances under our management across Europe,
          America, and Asia, we've built the expertise to handle infrastructure at any scale. Our
          global presence with offices in France, Spain, Canada, Colombia, and Japan ensures that
          our team is always ready to support you with 24/7 human service, no matter where you are.
        </p>

        <div class="grid md:grid-cols-2 gap-6">
          <!-- Our Locations -->
          <div
            v-motion
            :initial="{ opacity: 0, y: 30 }"
            :visibleOnce="{ opacity: 1, y: 0, transition: { duration: 600, delay: 400, ease: 'easeOut' } }"
          >
            <h4 class="font-semibold text-slate-900 mb-3">Our Locations</h4>
            <ul class="space-y-3 text-slate-700">
              <li
                v-for="(location, index) in locations"
                :key="location"
                v-motion
                :initial="{ opacity: 0, x: -20 }"
                :visibleOnce="{
                  opacity: 1,
                  x: 0,
                  transition: { duration: 600, delay: 500 + index * 80, ease: 'easeOut' },
                }"
                class="flex items-center gap-3"
              >
                <svg
                  class="w-[18px] h-[18px] text-blue-600 flex-shrink-0"
                  fill="none"
                  stroke="currentColor"
                  viewBox="0 0 24 24"
                >
                  <path
                    d="M20 10c0 4.993-5.539 10.193-7.399 11.799a1 1 0 0 1-1.202 0C9.539 20.193 4 14.993 4 10a8 8 0 0 1 16 0"
                  />
                  <circle cx="12" cy="10" r="3" />
                </svg>
                {{ location }}
              </li>
            </ul>
          </div>

          <!-- Our Coverage -->
          <div
            v-motion
            :initial="{ opacity: 0, y: 30 }"
            :visibleOnce="{ opacity: 1, y: 0, transition: { duration: 600, delay: 400, ease: 'easeOut' } }"
          >
            <h4 class="font-semibold text-slate-900 mb-3">Our Coverage</h4>
            <ul class="space-y-3 text-slate-700">
              <li
                v-for="(item, index) in coverage"
                :key="item.label"
                v-motion
                :initial="{ opacity: 0, x: 20 }"
                :visibleOnce="{
                  opacity: 1,
                  x: 0,
                  transition: { duration: 600, delay: 500 + index * 80, ease: 'easeOut' },
                }"
                class="flex items-center gap-3"
              >
                <span class="text-xl">{{ item.icon }}</span>
                {{ item.label }}
              </li>
            </ul>
          </div>
        </div>
      </div>
    </div>
  </section>
</template>
