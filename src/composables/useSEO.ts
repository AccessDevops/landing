import { onMounted, onUnmounted, watch, type Ref } from 'vue'

export interface SEOMetaTags {
  title?: string
  description?: string
  keywords?: string
  ogTitle?: string
  ogDescription?: string
  ogImage?: string
  ogUrl?: string
  ogType?: string
  twitterCard?: string
  twitterTitle?: string
  twitterDescription?: string
  twitterImage?: string
  canonical?: string
}

export interface StructuredData {
  '@context': string
  '@type': string
  [key: string]: any
}

export function useSEO(metaTags: SEOMetaTags | Ref<SEOMetaTags>, structuredData?: StructuredData | StructuredData[]) {
  const createdElements: HTMLElement[] = []

  const setMetaTag = (name: string, content: string, property = false) => {
    if (!content) return

    const attr = property ? 'property' : 'name'
    let element = document.querySelector(`meta[${attr}="${name}"]`) as HTMLMetaElement

    if (!element) {
      element = document.createElement('meta')
      element.setAttribute(attr, name)
      document.head.appendChild(element)
      createdElements.push(element)
    }

    element.setAttribute('content', content)
  }

  const setLinkTag = (rel: string, href: string) => {
    if (!href) return

    let element = document.querySelector(`link[rel="${rel}"]`) as HTMLLinkElement

    if (!element) {
      element = document.createElement('link')
      element.setAttribute('rel', rel)
      document.head.appendChild(element)
      createdElements.push(element)
    }

    element.setAttribute('href', href)
  }

  const setStructuredData = (data: StructuredData | StructuredData[]) => {
    const dataArray = Array.isArray(data) ? data : [data]

    dataArray.forEach((item, index) => {
      const id = `structured-data-${index}`
      let script = document.getElementById(id) as HTMLScriptElement

      if (!script) {
        script = document.createElement('script')
        script.id = id
        script.type = 'application/ld+json'
        document.head.appendChild(script)
        createdElements.push(script)
      }

      script.textContent = JSON.stringify(item)
    })
  }

  const updateMetaTags = (tags: SEOMetaTags) => {
    // Title
    if (tags.title) {
      document.title = tags.title
    }

    // Basic meta tags
    setMetaTag('description', tags.description || '')
    setMetaTag('keywords', tags.keywords || '')

    // Open Graph
    setMetaTag('og:title', tags.ogTitle || tags.title || '', true)
    setMetaTag('og:description', tags.ogDescription || tags.description || '', true)
    setMetaTag('og:image', tags.ogImage || '', true)
    setMetaTag('og:url', tags.ogUrl || window.location.href, true)
    setMetaTag('og:type', tags.ogType || 'website', true)

    // Twitter Card
    setMetaTag('twitter:card', tags.twitterCard || 'summary_large_image')
    setMetaTag('twitter:title', tags.twitterTitle || tags.ogTitle || tags.title || '')
    setMetaTag('twitter:description', tags.twitterDescription || tags.ogDescription || tags.description || '')
    setMetaTag('twitter:image', tags.twitterImage || tags.ogImage || '')

    // Canonical URL
    if (tags.canonical) {
      setLinkTag('canonical', tags.canonical)
    }
  }

  onMounted(() => {
    // Get tags value (handle Ref)
    const tags = 'value' in metaTags ? metaTags.value : metaTags
    updateMetaTags(tags)

    // Add structured data if provided
    if (structuredData) {
      setStructuredData(structuredData)
    }

    // Watch for reactive changes if metaTags is a Ref
    if ('value' in metaTags) {
      watch(metaTags, (newTags) => {
        updateMetaTags(newTags)
      })
    }
  })

  onUnmounted(() => {
    // Cleanup created elements
    createdElements.forEach((element) => {
      element.remove()
    })
    createdElements.length = 0
  })

  return {
    updateMetaTags,
    setStructuredData,
  }
}
