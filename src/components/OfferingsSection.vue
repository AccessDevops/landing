<script setup lang="ts">
import OfferingCard from './OfferingCard.vue'

const offerings = [
  {
    title: 'OTI',
    subtitle: 'One-Time Intervention',
    description:
      'A single time intervention on your infrastructure. Perfect for teams who need initial setup and want to manage it themselves afterward.',
    features: [],
    variant: 'purple' as const,
  },
  {
    title: 'WDI',
    subtitle: 'We Do It',
    description:
      'Complete infrastructure management based on GCP. We handle hosting, security, and deployments while you focus on your business.',
    features: [],
    variant: 'blue' as const,
  },
  {
    title: 'WIU',
    subtitle: 'We Integrate with You',
    description:
      'Our experts become an extension of your engineering team. We manage a part of your infrastructure while providing mentorship and knowledge transfer.',
    features: [],
    variant: 'orange' as const,
  },
]
</script>

<template>
  <section id="offerings" class="pt-20 pb-12 px-6 bg-slate-50" aria-labelledby="offerings-heading">
    <div class="max-w-7xl mx-auto">
      <h2
        id="offerings-heading"
        v-motion
        :initial="{ opacity: 0, y: 30 }"
        :visibleOnce="{ opacity: 1, y: 0, transition: { duration: 600, ease: 'easeOut' } }"
        class="text-4xl font-bold text-slate-900 mb-16 text-center"
      >
        Our Offerings
      </h2>

      <div class="grid grid-cols-1 md:grid-cols-3 gap-6 items-stretch">
        <div
          v-for="(offering, index) in offerings"
          :key="offering.title"
          v-motion
          :initial="{ opacity: 0, y: 30, scale: 0.95 }"
          :visibleOnce="{ opacity: 1, y: 0, scale: 1, transition: { duration: 600, delay: 200 + index * 100, ease: 'easeOut' } }"
          class="flex"
        >
          <OfferingCard
            :title="offering.title"
            :subtitle="offering.subtitle"
            :description="offering.description"
            :features="offering.features"
            :variant="offering.variant"
          />
        </div>
      </div>
    </div>
  </section>
</template>
