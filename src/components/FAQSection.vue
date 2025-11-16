<script setup lang="ts">
import AccordionItem from './AccordionItem.vue'

const faqs = [
  {
    question: 'Which cloud provider do you use?',
    answer:
      'We primarily partner with Google Cloud Platform, with over 8 years of partnership experience. This gives us access to cutting-edge infrastructure at competitive pricing. We also work with other major cloud providers based on your specific needs.',
  },
  {
    question: 'Where will my data be hosted?',
    answer:
      'Your data can be hosted in any of our global locations across Europe (France, Spain), Americas (Canada, Colombia), or Asia (Japan). We work with you to choose the optimal location based on your compliance requirements, latency needs, and business objectives.',
  },
  {
    question: 'What technology stack do you support?',
    answer:
      'We support a comprehensive range of technologies including Docker, GitLab, GitHub, Jenkins, Ubuntu, Debian, OpenVPN, and Bash scripting. Our team has extensive experience with modern DevOps tools and can adapt to your existing technology stack.',
  },
]
</script>

<template>
  <section id="faq" class="py-20 px-6 bg-slate-50" aria-labelledby="faq-heading" itemscope itemtype="https://schema.org/FAQPage">
    <div class="max-w-4xl mx-auto">
      <h2
        id="faq-heading"
        v-motion
        :initial="{ opacity: 0, y: 30 }"
        :visibleOnce="{ opacity: 1, y: 0, transition: { duration: 600, ease: 'easeOut' } }"
        class="text-4xl font-bold text-slate-900 mb-4 text-center"
      >
        FAQ
      </h2>
      <p
        v-motion
        :initial="{ opacity: 0, y: 30 }"
        :visibleOnce="{ opacity: 1, y: 0, transition: { duration: 600, delay: 100, ease: 'easeOut' } }"
        class="text-center text-slate-600 mb-12 text-lg"
      >
        Here are some of the most common questions we get from new clients
      </p>

      <div class="space-y-4">
        <div
          v-for="(faq, index) in faqs"
          :key="faq.question"
          v-motion
          :initial="{ opacity: 0, y: 30, scale: 0.98 }"
          :visibleOnce="{
            opacity: 1,
            y: 0,
            scale: 1,
            transition: { duration: 600, delay: 200 + index * 100, ease: 'easeOut' },
          }"
        >
          <AccordionItem :question="faq.question" :answer="faq.answer" />
        </div>
      </div>
    </div>
  </section>
</template>
