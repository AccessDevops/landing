<script setup lang="ts">
import AccordionItem from './AccordionItem.vue'

const faqs = [
  {
    question: 'Which cloud provider do you use?',
    answer:
      'We primarily use Google Cloud Platform (GCP). We\'ve been an official partner for over 5 years, have deployed numerous solutions on their infrastructure, and can now offer special pricing and optimized configurations to give you a competitive edge.',
  },
  {
    question: 'Where will my data be hosted?',
    answer:
      'For the WDI offer, your data will be hosted on our GCP infrastructure. You can choose from data centers located in:\n\n🌍 Europe (Belgium)\n🌎 North America (US or Canada)\n🌏 Asia\n\nWe always help you select the best region for performance, compliance, and cost.\n\nFor WIU you will have your dedicated GCP account so you will be able to choose from all the GCP available regions.',
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
          <AccordionItem v-if="faq.question === 'Where will my data be hosted?'" :question="faq.question">
            <p class="text-slate-700 leading-relaxed mb-3">
              <span class="font-semibold">For the WDI offer,</span> your data will be hosted on our GCP infrastructure. You can choose from data centers located in:
            </p>
            <ul class="text-slate-700 space-y-2 mb-4 ml-4">
              <li>🌍 Europe (Belgium)</li>
              <li>🌎 North America (US or Canada)</li>
              <li>🌏 Asia</li>
            </ul>
            <p class="text-slate-700 leading-relaxed mb-3">
              We always help you select the best region for performance, compliance, and cost.
            </p>
            <p class="text-slate-700 leading-relaxed">
              <span class="font-semibold">For WIU</span> you will have your dedicated GCP account so you will be able to choose from all the GCP available regions.
            </p>
          </AccordionItem>
          <AccordionItem v-else-if="faq.question === 'What technology stack do you support?'" :question="faq.question">
            <p class="text-slate-700 leading-relaxed mb-4">
              We currently support a wide range of stacks, including:
            </p>
            <div class="grid md:grid-cols-2 gap-4 mb-4">
              <div>
                <p class="font-semibold text-slate-900 mb-2">Languages:</p>
                <ul class="text-slate-700 space-y-1 text-sm">
                  <li>Java: 8, 11, 17, 21</li>
                  <li>Python: 3.11 - 3.14</li>
                  <li>Node.js: 14, 22, 24</li>
                  <li>PHP: 7.4, 8.2, 8.4</li>
                </ul>
              </div>
              <div>
                <p class="font-semibold text-slate-900 mb-2">Databases &amp; Tools:</p>
                <ul class="text-slate-700 space-y-1 text-sm">
                  <li>PostgreSQL (13-17), MySQL (8.4), MariaDB (10-12)</li>
                  <li>Redis (8), MinIO</li>
                  <li>Grafana (10-12), Loki (2.4-3.4)</li>
                  <li>Elasticsearch (8-9), VictoriaMetrics</li>
                </ul>
              </div>
            </div>
            <p class="text-slate-700 leading-relaxed text-sm italic">
              If you don't see your preferred stack listed, <span class="font-semibold">contact us</span> - our team can integrate it for you.
            </p>
          </AccordionItem>
          <AccordionItem v-else :question="faq.question" :answer="faq.answer" />
        </div>
      </div>
    </div>
  </section>
</template>
