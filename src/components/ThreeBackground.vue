<script setup lang="ts">
import { onMounted, onUnmounted, ref } from 'vue'
import * as THREE from 'three'

const canvasRef = ref<HTMLCanvasElement>()
let scene: THREE.Scene
let camera: THREE.PerspectiveCamera
let renderer: THREE.WebGLRenderer
let particles: THREE.Points
let lines: THREE.LineSegments
let animationId: number
let particlePositions: Float32Array
let linePositions: Float32Array

onMounted(() => {
  if (!canvasRef.value) return

  // Setup scene
  scene = new THREE.Scene()
  camera = new THREE.PerspectiveCamera(75, window.innerWidth / window.innerHeight, 0.1, 1000)
  camera.position.z = 50

  // Setup renderer
  renderer = new THREE.WebGLRenderer({
    canvas: canvasRef.value,
    alpha: true,
    antialias: true,
  })
  renderer.setSize(window.innerWidth, window.innerHeight)
  renderer.setPixelRatio(Math.min(window.devicePixelRatio, 2))

  // Create particles with network effect
  const particlesCount = 150
  const maxConnections = 5000
  const maxDistance = 15

  particlePositions = new Float32Array(particlesCount * 3)
  const particleVelocities: Array<{ x: number; y: number; z: number }> = []

  // Initialize particles
  for (let i = 0; i < particlesCount; i++) {
    const i3 = i * 3
    particlePositions[i3] = (Math.random() - 0.5) * 80
    particlePositions[i3 + 1] = (Math.random() - 0.5) * 80
    particlePositions[i3 + 2] = (Math.random() - 0.5) * 80

    // Random velocity
    particleVelocities.push({
      x: (Math.random() - 0.5) * 0.05,
      y: (Math.random() - 0.5) * 0.05,
      z: (Math.random() - 0.5) * 0.05,
    })
  }

  const particlesGeometry = new THREE.BufferGeometry()
  particlesGeometry.setAttribute('position', new THREE.BufferAttribute(particlePositions, 3))

  const particlesMaterial = new THREE.PointsMaterial({
    size: 0.8,
    color: 0x2563eb, // blue-600
    transparent: true,
    opacity: 0.7,
    sizeAttenuation: true,
  })

  particles = new THREE.Points(particlesGeometry, particlesMaterial)
  scene.add(particles)

  // Create lines for connections
  linePositions = new Float32Array(maxConnections * 2 * 3)
  const lineGeometry = new THREE.BufferGeometry()
  lineGeometry.setAttribute('position', new THREE.BufferAttribute(linePositions, 3))

  const lineMaterial = new THREE.LineBasicMaterial({
    color: 0x06b6d4, // cyan-500
    transparent: true,
    opacity: 0.15,
    blending: THREE.AdditiveBlending,
  })

  lines = new THREE.LineSegments(lineGeometry, lineMaterial)
  scene.add(lines)

  // Animation
  const animate = () => {
    animationId = requestAnimationFrame(animate)

    // Update particle positions
    for (let i = 0; i < particlesCount; i++) {
      const i3 = i * 3
      const velocity = particleVelocities[i]
      if (!velocity) continue

      particlePositions[i3]! += velocity.x
      particlePositions[i3 + 1]! += velocity.y
      particlePositions[i3 + 2]! += velocity.z

      // Bounce off boundaries
      if (particlePositions[i3]! < -40 || particlePositions[i3]! > 40) {
        velocity.x = -velocity.x
      }
      if (particlePositions[i3 + 1]! < -40 || particlePositions[i3 + 1]! > 40) {
        velocity.y = -velocity.y
      }
      if (particlePositions[i3 + 2]! < -40 || particlePositions[i3 + 2]! > 40) {
        velocity.z = -velocity.z
      }
    }

    // Update connections
    let connectionCount = 0
    for (let i = 0; i < particlesCount && connectionCount < maxConnections; i++) {
      const i3 = i * 3
      for (let j = i + 1; j < particlesCount && connectionCount < maxConnections; j++) {
        const j3 = j * 3

        const dx = particlePositions[i3]! - particlePositions[j3]!
        const dy = particlePositions[i3 + 1]! - particlePositions[j3 + 1]!
        const dz = particlePositions[i3 + 2]! - particlePositions[j3 + 2]!
        const distance = Math.sqrt(dx * dx + dy * dy + dz * dz)

        if (distance < maxDistance) {
          const pos = connectionCount * 6
          linePositions[pos] = particlePositions[i3]!
          linePositions[pos + 1] = particlePositions[i3 + 1]!
          linePositions[pos + 2] = particlePositions[i3 + 2]!
          linePositions[pos + 3] = particlePositions[j3]!
          linePositions[pos + 4] = particlePositions[j3 + 1]!
          linePositions[pos + 5] = particlePositions[j3 + 2]!
          connectionCount++
        }
      }
    }

    particles.geometry.attributes.position!.needsUpdate = true
    lines.geometry.setDrawRange(0, connectionCount * 2)
    lines.geometry.attributes.position!.needsUpdate = true

    // Slow rotation
    particles.rotation.y += 0.0002
    lines.rotation.y += 0.0002

    renderer.render(scene, camera)
  }

  animate()

  // Handle resize
  const handleResize = () => {
    camera.aspect = window.innerWidth / window.innerHeight
    camera.updateProjectionMatrix()
    renderer.setSize(window.innerWidth, window.innerHeight)
  }

  window.addEventListener('resize', handleResize)

  // Mouse movement for subtle parallax
  const handleMouseMove = (event: MouseEvent) => {
    const mouseX = (event.clientX / window.innerWidth) * 2 - 1
    const mouseY = -(event.clientY / window.innerHeight) * 2 + 1

    camera.position.x = mouseX * 3
    camera.position.y = mouseY * 3
  }

  window.addEventListener('mousemove', handleMouseMove)

  onUnmounted(() => {
    window.removeEventListener('resize', handleResize)
    window.removeEventListener('mousemove', handleMouseMove)
  })
})

onUnmounted(() => {
  if (animationId) {
    cancelAnimationFrame(animationId)
  }
  if (renderer) {
    renderer.dispose()
  }
  if (particles) {
    particles.geometry.dispose()
    if (particles.material instanceof THREE.Material) {
      particles.material.dispose()
    }
  }
  if (lines) {
    lines.geometry.dispose()
    if (lines.material instanceof THREE.Material) {
      lines.material.dispose()
    }
  }
})
</script>

<template>
  <canvas ref="canvasRef" class="absolute inset-0 w-full h-full -z-10" />
</template>
