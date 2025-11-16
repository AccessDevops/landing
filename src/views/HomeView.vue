<script setup lang="ts">
import HeroSection from '@/components/HeroSection.vue'
import OfferingsSection from '@/components/OfferingsSection.vue'
import ComparisonTable from '@/components/ComparisonTable.vue'
import TechnologySection from '@/components/TechnologySection.vue'
import ContactSection from '@/components/ContactSection.vue'
import AboutSection from '@/components/AboutSection.vue'
import FAQSection from '@/components/FAQSection.vue'
import FooterSection from '@/components/FooterSection.vue'
import { useSEO } from '@/composables/useSEO'
import { allStructuredData } from '@/composables/useStructuredData'

// SEO Configuration for Home Page
useSEO(
  {
    title: 'AccessDevOps - DevOps & Infrastructure Success as a Service',
    description:
      'Complete infrastructure management and DevOps services. 167+ customers, 1,084+ managed servers, 24/7 expert support. Google Cloud partnership since 8+ years.',
    keywords:
      'DevOps, Infrastructure Management, Cloud Hosting, Google Cloud, Docker, Managed Services, 24/7 Support, Infrastructure as a Service, WDI, WIU',
    ogTitle: 'AccessDevOps - DevOps & Infrastructure Success as a Service',
    ogDescription:
      'Spend less. Stay secure. Get real human experts to manage your infrastructure that support your business. 167+ active customers worldwide.',
    ogImage: 'https://accessdevops.com/og-image.jpg',
    ogUrl: 'https://accessdevops.com/',
    ogType: 'website',
    twitterCard: 'summary_large_image',
    canonical: 'https://accessdevops.com/',
  },
  allStructuredData,
)
</script>

<template>
  <div class="min-h-screen bg-white">
    <HeroSection />
    <OfferingsSection />
    <ComparisonTable />
    <TechnologySection />
    <ContactSection />
    <AboutSection />
    <FAQSection />
    <FooterSection />
  </div>
</template>
