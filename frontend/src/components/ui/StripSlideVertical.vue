<script setup>
defineProps({
  height: { type: String, default: '240px' }
});
</script>

<template>
  <div class="tape-container" :style="{ height: height }">
    <div class="tape-track">
      <div class="tape-segment" v-for="i in 18" :key="i">
        <div class="stripe"></div>
        <div class="stripe field"></div>
        <div class="stripe"></div>
        <div class="stripe field"></div>
      </div>

      <div class="tape-segment" v-for="i in 18" :key="`duplicate-${i}`">
        <div class="stripe"></div>
        <div class="stripe field"></div>
        <div class="stripe"></div>
        <div class="stripe field"></div>
      </div>
    </div>
  </div>
</template>

<style scoped>
.tape-container {
  width: 100%;
  overflow: hidden;
  background: var(--bg);
  border-top: 2px solid var(--border);
  border-bottom: 2px solid var(--border);
  padding: 0 8px;
  display: flex;
  justify-content: center;
  position: relative;
}

.tape-track {
  display: flex;
  flex-direction: column;
  height: max-content;
  animation: slideVertical 32s linear infinite;
  align-items: center;
}

.tape-segment {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 14px;
  padding-bottom: 14px;
}

.stripe {
  width: 42px;
  height: 60px;
  border: 2px solid var(--accent);
  transform: skewY(-25deg);
  background: transparent;
  flex-shrink: 0;
}

.stripe.field {
  background-color: var(--accent);
}

@keyframes slideVertical {
  from {
    transform: translateY(0);
  }

  to {
    transform: translateY(-50%);
  }
}

@media (max-width: 768px) {
  .stripe {
    width: 32px;
    height: 44px;
  }

  .tape-segment {
    gap: 10px;
    padding-bottom: 10px;
  }
}
</style>