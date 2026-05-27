<script>
export default {
  name: 'TableList',
  props: {
    dados: {
      required: true,
      type: Array
    },
    columns: {
      type: Array,
      required: true
    },
    show: {
      type: Boolean,
      default: false
    },
    title: {
      type: String,
      default: 'Listagem'
    }
  },
  emits: ['close'],
  computed: {
    isEmpty() {
      return !this.dados || this.dados.length === 0;
    }
  }
}
</script>

<template>
  <Teleport to="body">
    <Transition name="modal-fade">
      <div
          v-if="show"
          class="table-overlay"
          @click.self="$emit('close')"
          role="dialog"
          aria-modal="true"
          :aria-label="title"
      >
        <div class="table-modal">

          <div class="modal-strip">
            <div class="strip-track">
              <span v-for="i in 32" :key="i" class="strip-item">
                <span class="strip-bar"></span>
                <span class="strip-bar strip-bar--filled"></span>
              </span>
            </div>
          </div>

          <header class="modal-header">
            <div class="header-left">
              <span class="header-kicker">Tabela</span>
              <h3 class="header-title">{{ title }}</h3>
            </div>
            <button
                class="close-btn"
                @click="$emit('close')"
                aria-label="Fechar modal"
            >
              &times;
            </button>
          </header>

          <div class="modal-body">
            <div v-if="isEmpty" class="empty-state">
              <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" aria-hidden="true">
                <path d="M3 7h18M3 12h18M3 17h18" stroke-linecap="round"/>
              </svg>
              <p>Nenhum registro encontrado</p>
            </div>

            <div v-else class="table-wrapper">
              <table class="data-table">
                <thead>
                <tr>
                  <th v-for="col in columns" :key="col.key || col.label">
                    {{ col.label }}
                  </th>
                </tr>
                </thead>
                <tbody>
                <tr v-for="(row, rowIndex) in dados" :key="rowIndex">
                  <td v-for="col in columns" :key="col.key || col.label">
                    <slot :name="col.key" :value="row[col.key]" :row="row">
                      {{ row[col.key] ?? '—' }}
                    </slot>
                  </td>
                </tr>
                </tbody>
              </table>
            </div>
          </div>

          <footer class="modal-footer">
            <span class="footer-count">
              {{ isEmpty ? 'Sem registros' : `${dados.length} registro${dados.length !== 1 ? 's' : ''}` }}
            </span>
            <button class="btn-close" @click="$emit('close')">Fechar</button>
          </footer>

        </div>
      </div>
    </Transition>
  </Teleport>
</template>

<style scoped>
.table-overlay {
  position: fixed;
  inset: 0;
  background: rgba(0, 0, 0, 0.72);
  display: flex;
  align-items: center;
  justify-content: center;
  z-index: 9999;
  backdrop-filter: blur(5px);
  padding: 24px;
}

.table-modal {
  background: #0e0e12;
  width: 100%;
  max-width: 820px;
  max-height: 88vh;
  border-radius: 18px;
  border: 1px solid rgba(255, 255, 255, 0.09);
  box-shadow:
      0 24px 60px rgba(0, 0, 0, 0.55),
      0 0 0 1px rgba(243, 223, 19, 0.06),
      inset 0 1px 0 rgba(255, 255, 255, 0.03);
  display: flex;
  flex-direction: column;
  overflow: hidden;
}

/* ── Mini strip decorativo ── */
.modal-strip {
  height: 28px;
  overflow: hidden;
  background: rgba(0, 0, 0, 0.3);
  border-bottom: 1px solid rgba(255, 255, 255, 0.06);
}

.strip-track {
  display: flex;
  align-items: center;
  height: 100%;
  gap: 10px;
  padding: 0 12px;
  animation: stripSlide 18s linear infinite;
  width: max-content;
}

.strip-item {
  display: flex;
  align-items: center;
  gap: 10px;
}

.strip-bar {
  display: block;
  width: 32px;
  height: 12px;
  border: 1.5px solid rgba(243, 223, 19, 0.35);
  transform: skewX(-22deg);
  flex-shrink: 0;
}

.strip-bar--filled {
  background-color: rgba(243, 223, 19, 0.28);
}

@keyframes stripSlide {
  from { transform: translateX(0); }
  to   { transform: translateX(-50%); }
}

.modal-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 20px 24px 16px;
  border-bottom: 1px solid rgba(255, 255, 255, 0.07);
  flex-shrink: 0;
}

.header-left {
  display: flex;
  flex-direction: column;
  gap: 3px;
}

.header-kicker {
  font-size: 0.72rem;
  font-weight: 800;
  letter-spacing: 0.12em;
  text-transform: uppercase;
  color: #f3df13;
}

.header-title {
  margin: 0;
  font-size: 1.1rem;
  font-weight: 800;
  letter-spacing: 0.04em;
  text-transform: uppercase;
  color: #f5f5f7;
}

.close-btn {
  background: none;
  border: none;
  font-size: 1.6rem;
  line-height: 1;
  color: rgba(255, 255, 255, 0.45);
  cursor: pointer;
  padding: 4px 8px;
  border-radius: 8px;
  transition: color 160ms ease, background 160ms ease;
}

.close-btn:hover {
  color: #ff4d57;
  background: rgba(255, 77, 87, 0.1);
}

/* ── Body + Tabela ── */
.modal-body {
  flex: 1;
  overflow: auto;
  min-height: 0;
}

.table-wrapper {
  overflow: auto;
  width: 100%;
}

.data-table {
  width: 100%;
  border-collapse: collapse;
  font-size: 0.92rem;
  color: #d8d8e0;
}

.data-table thead tr {
  border-bottom: 1px solid rgba(243, 223, 19, 0.18);
  background: rgba(243, 223, 19, 0.04);
}

.data-table thead th {
  padding: 12px 18px;
  text-align: left;
  font-size: 0.72rem;
  font-weight: 800;
  letter-spacing: 0.1em;
  text-transform: uppercase;
  color: rgba(243, 223, 19, 0.8);
  white-space: nowrap;
}

.data-table tbody tr {
  border-bottom: 1px solid rgba(255, 255, 255, 0.05);
  transition: background 140ms ease;
}

.data-table tbody tr:hover {
  background: rgba(255, 255, 255, 0.03);
}

.data-table tbody tr:last-child {
  border-bottom: none;
}

.data-table td {
  padding: 12px 18px;
  color: #c8c8d4;
  white-space: nowrap;
}

.empty-state {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  gap: 14px;
  padding: 56px 24px;
  color: rgba(255, 255, 255, 0.3);
}

.empty-state svg {
  width: 44px;
  height: 44px;
  opacity: 0.5;
}

.empty-state p {
  margin: 0;
  font-size: 0.9rem;
  font-weight: 600;
  letter-spacing: 0.04em;
}

.modal-footer {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 14px 24px;
  border-top: 1px solid rgba(255, 255, 255, 0.07);
  background: rgba(255, 255, 255, 0.015);
  flex-shrink: 0;
}

.footer-count {
  font-size: 0.8rem;
  color: rgba(255, 255, 255, 0.35);
  font-weight: 600;
  letter-spacing: 0.04em;
}

.btn-close {
  min-height: 38px;
  padding: 0 18px;
  border-radius: 10px;
  border: 1px solid rgba(255, 255, 255, 0.12);
  background: rgba(255, 255, 255, 0.05);
  color: #d8d8e0;
  font-size: 0.88rem;
  font-weight: 700;
  cursor: pointer;
  transition: background 160ms ease, border-color 160ms ease;
}

.btn-close:hover {
  background: rgba(255, 255, 255, 0.09);
  border-color: rgba(255, 255, 255, 0.2);
}

.modal-fade-enter-active,
.modal-fade-leave-active {
  transition: opacity 200ms ease;
}

.modal-fade-enter-active .table-modal,
.modal-fade-leave-active .table-modal {
  transition: transform 200ms cubic-bezier(0.16, 1, 0.3, 1), opacity 200ms ease;
}

.modal-fade-enter-from,
.modal-fade-leave-to {
  opacity: 0;
}

.modal-fade-enter-from .table-modal {
  transform: scale(0.96) translateY(12px);
  opacity: 0;
}


@media (max-width: 600px) {
  .table-overlay {
    padding: 12px;
    align-items: flex-end;
  }

  .table-modal {
    max-height: 92vh;
    border-radius: 18px 18px 0 0;
  }

  .data-table thead th,
  .data-table td {
    padding: 10px 14px;
  }
}
</style>