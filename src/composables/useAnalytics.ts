/**
 * Analytics composable for Google Analytics 4
 * No external dependencies - uses native gtag API
 */

// Extend Window interface to include gtag
declare global {
  interface Window {
    gtag?: (...args: any[]) => void
    dataLayer?: any[]
  }
}

export function useAnalytics() {
  /**
   * Track a custom event
   */
  const trackEvent = (eventName: string, params?: Record<string, any>) => {
    if (typeof window !== 'undefined' && window.gtag) {
      window.gtag('event', eventName, params)
    } else {
      console.warn('Google Analytics not loaded')
    }
  }

  /**
   * Track page view
   */
  const trackPageView = (pagePath: string, pageTitle?: string) => {
    if (typeof window !== 'undefined' && window.gtag) {
      window.gtag('event', 'page_view', {
        page_path: pagePath,
        page_title: pageTitle || document.title,
      })
    }
  }

  /**
   * Track booking events
   */
  const trackBookingEvent = (
    action: 'modal_opened' | 'date_selected' | 'time_selected' | 'submitted' | 'completed',
    metadata?: Record<string, any>
  ) => {
    const eventMap = {
      modal_opened: 'booking_modal_opened',
      date_selected: 'booking_date_selected',
      time_selected: 'booking_time_selected',
      submitted: 'booking_submitted',
      completed: 'booking_completed',
    }

    trackEvent(eventMap[action], {
      event_category: 'booking',
      ...metadata,
    })
  }

  /**
   * Track CTA clicks
   */
  const trackCTA = (location: string, label?: string) => {
    trackEvent('cta_clicked', {
      event_category: 'engagement',
      event_label: label || location,
      location,
    })
  }

  /**
   * Track scroll depth
   */
  const trackScrollDepth = (percent: number) => {
    trackEvent('scroll_depth', {
      event_category: 'engagement',
      percent,
    })
  }

  /**
   * Track technology interactions
   */
  const trackTechnology = (technology: string, action: 'view' | 'click') => {
    trackEvent('technology_interaction', {
      event_category: 'engagement',
      technology,
      action,
    })
  }

  /**
   * Track contact interactions
   */
  const trackContact = (method: 'email' | 'linkedin' | 'phone') => {
    trackEvent('contact_clicked', {
      event_category: 'engagement',
      method,
    })
  }

  return {
    trackEvent,
    trackPageView,
    trackBookingEvent,
    trackCTA,
    trackScrollDepth,
    trackTechnology,
    trackContact,
  }
}
