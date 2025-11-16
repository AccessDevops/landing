import type { StructuredData } from './useSEO'

// Organization Schema
export const organizationSchema: StructuredData = {
  '@context': 'https://schema.org',
  '@type': 'Organization',
  name: 'AccessDevOps',
  url: 'https://accessdevops.com',
  logo: 'https://accessdevops.com/logo.png',
  description:
    'DevOps & Infrastructure Success as a Service. Complete infrastructure management with 167+ active customers, 1,084+ managed servers, and 3,412+ major deployments.',
  email: 'contact@accessdevops.com',
  telephone: '+33-XXX-XXX-XXX',
  foundingDate: '2015',
  numberOfEmployees: {
    '@type': 'QuantitativeValue',
    value: '50-100',
  },
  address: [
    {
      '@type': 'PostalAddress',
      addressCountry: 'FR',
      addressLocality: 'France',
    },
    {
      '@type': 'PostalAddress',
      addressCountry: 'ES',
      addressLocality: 'Spain',
    },
    {
      '@type': 'PostalAddress',
      addressCountry: 'CA',
      addressLocality: 'Canada',
    },
    {
      '@type': 'PostalAddress',
      addressCountry: 'CO',
      addressLocality: 'Colombia',
    },
    {
      '@type': 'PostalAddress',
      addressCountry: 'JP',
      addressLocality: 'Japan',
    },
  ],
  areaServed: ['Europe', 'North America', 'South America', 'Asia'],
  sameAs: [
    // Add social media URLs here when available
    // 'https://www.linkedin.com/company/accessdevops',
    // 'https://twitter.com/accessdevops',
    // 'https://github.com/accessdevops'
  ],
  contactPoint: {
    '@type': 'ContactPoint',
    contactType: 'Customer Support',
    email: 'contact@accessdevops.com',
    availableLanguage: ['English', 'French', 'Spanish', 'Japanese'],
    areaServed: 'Worldwide',
  },
}

// Service Schemas
export const wdiServiceSchema: StructuredData = {
  '@context': 'https://schema.org',
  '@type': 'Service',
  name: 'WDI - We Do It',
  description:
    'Complete infrastructure management. We handle hosting, security, and deployments while you focus on your business.',
  provider: {
    '@type': 'Organization',
    name: 'AccessDevOps',
  },
  serviceType: 'Infrastructure Management',
  areaServed: 'Worldwide',
  hasOfferCatalog: {
    '@type': 'OfferCatalog',
    name: 'WDI Service Features',
    itemListElement: [
      {
        '@type': 'Offer',
        itemOffered: {
          '@type': 'Service',
          name: 'Full hosting management',
        },
      },
      {
        '@type': 'Offer',
        itemOffered: {
          '@type': 'Service',
          name: 'Enterprise-grade security',
        },
      },
      {
        '@type': 'Offer',
        itemOffered: {
          '@type': 'Service',
          name: 'Automated deployments',
        },
      },
      {
        '@type': 'Offer',
        itemOffered: {
          '@type': 'Service',
          name: '24/7 support included',
        },
      },
    ],
  },
}

export const wiuServiceSchema: StructuredData = {
  '@context': 'https://schema.org',
  '@type': 'Service',
  name: 'WIU - We Integrate with You',
  description:
    'Our experts become an extension of your engineering team. We manage your infrastructure while providing mentorship and knowledge transfer.',
  provider: {
    '@type': 'Organization',
    name: 'AccessDevOps',
  },
  serviceType: 'DevOps Consulting & Infrastructure Management',
  areaServed: 'Worldwide',
  hasOfferCatalog: {
    '@type': 'OfferCatalog',
    name: 'WIU Service Features',
    itemListElement: [
      {
        '@type': 'Offer',
        itemOffered: {
          '@type': 'Service',
          name: 'Dedicated infrastructure team',
        },
      },
      {
        '@type': 'Offer',
        itemOffered: {
          '@type': 'Service',
          name: 'Knowledge transfer & training',
        },
      },
      {
        '@type': 'Offer',
        itemOffered: {
          '@type': 'Service',
          name: 'Scalable management',
        },
      },
      {
        '@type': 'Offer',
        itemOffered: {
          '@type': 'Service',
          name: 'Mentorship included',
        },
      },
    ],
  },
}

// FAQ Schema
export const faqSchema: StructuredData = {
  '@context': 'https://schema.org',
  '@type': 'FAQPage',
  mainEntity: [
    {
      '@type': 'Question',
      name: 'Which cloud provider do you use?',
      acceptedAnswer: {
        '@type': 'Answer',
        text: 'We primarily use Google Cloud Platform (GCP) as our main infrastructure partner. We have maintained an 8+ year partnership with Google Cloud, giving us access to cutting-edge infrastructure at competitive pricing. We also work with other cloud providers based on specific client needs.',
      },
    },
    {
      '@type': 'Question',
      name: 'Where will my data be hosted?',
      acceptedAnswer: {
        '@type': 'Answer',
        text: 'Your data can be hosted in any of the Google Cloud regions worldwide. We have a global presence with offices in France, Spain, Canada, Colombia, and Japan, and can deploy your infrastructure in the region that best suits your compliance requirements and performance needs. We support deployments across Europe, Americas, and Asia.',
      },
    },
    {
      '@type': 'Question',
      name: 'What technology stack do you support?',
      acceptedAnswer: {
        '@type': 'Answer',
        text: 'We support a wide range of technologies including Google Cloud Platform, Docker containers, GitLab, GitHub, Jenkins for CI/CD, Ubuntu and Debian Linux distributions, OpenVPN for secure networking, and various automation tools. Our team has expertise in modern DevOps practices and can adapt to your specific technology requirements.',
      },
    },
  ],
}

// Website Schema
export const websiteSchema: StructuredData = {
  '@context': 'https://schema.org',
  '@type': 'WebSite',
  name: 'AccessDevOps',
  url: 'https://accessdevops.com',
  description: 'DevOps & Infrastructure Success as a Service',
  publisher: {
    '@type': 'Organization',
    name: 'AccessDevOps',
  },
  potentialAction: {
    '@type': 'SearchAction',
    target: 'https://accessdevops.com/?s={search_term_string}',
    'query-input': 'required name=search_term_string',
  },
}

// Aggregate all schemas
export const allStructuredData = [
  organizationSchema,
  websiteSchema,
  wdiServiceSchema,
  wiuServiceSchema,
  faqSchema,
]
