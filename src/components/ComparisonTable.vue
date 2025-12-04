<script setup lang="ts">
interface ComparisonRow {
  service: string
  oti: string | boolean
  wdi: string | boolean
  wiu: string | boolean
}

const comparisonData: ComparisonRow[] = [
  { service: 'Access fee', oti: 'Starting at 199€', wdi: '689€ monthly', wiu: '1099€ monthly' },
  { service: 'One time Setup fee', oti: false, wdi: '3 x 266€', wiu: '3 x 266€' },
  { service: 'Initial Code Base Review', oti: true, wdi: true, wiu: true },
  { service: 'Define Deployment Requirements', oti: true, wdi: true, wiu: true },
  { service: 'CI/CD Pipeline Setup', oti: 'optional', wdi: true, wiu: true },
  { service: 'Setup Static Analysis & Linting', oti: 'optional', wdi: true, wiu: true },
  { service: 'Setup Containerization', oti: 'optional', wdi: true, wiu: true },
  { service: 'Perform Security Check', oti: '1', wdi: 'monthly', wiu: 'monthly' },
  { service: 'Maintain Monitoring & Logging', oti: false, wdi: true, wiu: true },
  { service: 'Documentation & Knowledge Transfer', oti: true, wdi: true, wiu: true },
  { service: 'Free Training & Meetings', oti: false, wdi: '5h monthly', wiu: '12h monthly' },
  {
    service: 'Free Pipeline or Containerization changes',
    oti: false,
    wdi: '2 monthly',
    wiu: '5 monthly',
  },
  { service: 'Yaml file, Dockerfile, SSH Access', oti: false, wdi: 'optional', wiu: true },
  { service: 'Image Access', oti: false, wdi: true, wiu: true },
  { service: 'GCP Organisation Management', oti: false, wdi: true, wiu: false },
  { service: 'GCP Server, Network, Storage Management', oti: false, wdi: true, wiu: true },
  { service: 'GCP CPU Unit Monthly Cost', oti: false, wdi: '15$', wiu: '23$' },
  { service: 'GCP RAM Unit Monthly Cost', oti: false, wdi: '3$', wiu: '5$' },
  {
    service: 'Database, shared storage, caching...',
    oti: 'Starting at 14€',
    wdi: 'Starting at 14€',
    wiu: 'Starting at 14€',
  },
  {
    service: 'Staging Environnement',
    oti: 'Starting at 49€',
    wdi: 'Starting at 49€',
    wiu: 'Starting at 49€',
  },
  {
    service: 'Domain with SSL/TLS.',
    oti: 'Starting at 5€',
    wdi: 'Starting at 5€',
    wiu: 'Starting at 5€',
  },
  { service: 'Extra Pipeline or Containerization changes', oti: '99€', wdi: '99€', wiu: '99€' },
]
</script>

<template>
  <section id="comparison" class="pt-8 pb-20 px-6 bg-slate-50 scroll-mt-20">
    <div class="max-w-6xl mx-auto">
      <!-- <h2
        v-motion
        :initial="{ opacity: 0, y: 30 }"
        :visibleOnce="{ opacity: 1, y: 0, transition: { duration: 600 } }"
        class="text-4xl font-bold text-slate-900 mb-4 text-center"
      >
        Detailed Comparison
      </h2> -->
      <p
        v-motion
        :initial="{ opacity: 0, y: 30 }"
        :visibleOnce="{ opacity: 1, y: 0, transition: { duration: 600, delay: 100, ease: 'easeOut' } }"
        class="text-center text-slate-600 mb-16 text-lg"
      >
        See exactly what's included in each offering
      </p>

      <div
        v-motion
        :initial="{ opacity: 0, y: 30, scale: 0.98 }"
        :visibleOnce="{ opacity: 1, y: 0, scale: 1, transition: { duration: 600, delay: 200, ease: 'easeOut' } }"
        class="bg-white rounded-xl shadow-lg border border-slate-200 overflow-hidden"
      >
        <!-- Table Header -->
        <div class="bg-gradient-to-r from-blue-600 to-cyan-600">
          <div class="grid grid-cols-4 gap-3 px-6 py-5">
            <div class="col-span-1">
              <h3 class="text-lg font-bold text-white"></h3>
            </div>
            <div class="text-center">
              <h4 class="text-lg font-bold text-white">OTI</h4>
              <p class="text-xs text-blue-100 mt-1">One-Time Intervention</p>
            </div>
            <div class="text-center">
              <h4 class="text-lg font-bold text-white">WDI</h4>
              <p class="text-xs text-blue-100 mt-1">We Do It</p>
            </div>
            <div class="text-center">
              <h4 class="text-lg font-bold text-white">WIU</h4>
              <p class="text-xs text-blue-100 mt-1">We Integrate with You</p>
            </div>
          </div>
        </div>

        <!-- Table Body -->
        <div>
          <div
            v-for="(row, index) in comparisonData"
            :key="row.service"
            class="grid grid-cols-4 gap-3 px-6 py-4 border-b border-slate-100 last:border-b-0 hover:bg-slate-50 transition-colors"
          >
            <!-- Service Name -->
            <div class="col-span-1 flex items-center">
              <p class="text-slate-800 font-medium">{{ row.service }}</p>
            </div>

            <!-- OTI Column -->
            <div class="flex items-center justify-center">
              <div v-if="typeof row.oti === 'boolean'">
                <div v-if="row.oti" class="text-blue-600">
                  <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path
                      stroke-linecap="round"
                      stroke-linejoin="round"
                      stroke-width="2"
                      d="M5 13l4 4L19 7"
                    />
                  </svg>
                </div>
                <div v-else class="text-slate-300">
                  <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path
                      stroke-linecap="round"
                      stroke-linejoin="round"
                      stroke-width="2"
                      d="M20 12H4"
                    />
                  </svg>
                </div>
              </div>
              <div v-else>
                <span class="text-slate-700 font-semibold">{{ row.oti }}</span>
              </div>
            </div>

            <!-- WDI Column -->
            <div class="flex items-center justify-center">
              <div v-if="typeof row.wdi === 'boolean'">
                <div v-if="row.wdi" class="text-blue-600">
                  <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path
                      stroke-linecap="round"
                      stroke-linejoin="round"
                      stroke-width="2"
                      d="M5 13l4 4L19 7"
                    />
                  </svg>
                </div>
                <div v-else class="text-slate-300">
                  <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path
                      stroke-linecap="round"
                      stroke-linejoin="round"
                      stroke-width="2"
                      d="M20 12H4"
                    />
                  </svg>
                </div>
              </div>
              <div v-else>
                <span class="text-slate-700 font-semibold">{{ row.wdi }}</span>
              </div>
            </div>

            <!-- WIU Column -->
            <div class="flex items-center justify-center">
              <div v-if="typeof row.wiu === 'boolean'">
                <div v-if="row.wiu" class="text-blue-600">
                  <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path
                      stroke-linecap="round"
                      stroke-linejoin="round"
                      stroke-width="2"
                      d="M5 13l4 4L19 7"
                    />
                  </svg>
                </div>
                <div v-else class="text-slate-300">
                  <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path
                      stroke-linecap="round"
                      stroke-linejoin="round"
                      stroke-width="2"
                      d="M20 12H4"
                    />
                  </svg>
                </div>
              </div>
              <div v-else>
                <span class="text-slate-700 font-semibold">{{ row.wiu }}</span>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>
</template>
