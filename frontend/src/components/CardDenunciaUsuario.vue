<template>
  <div class="denuncia-card">
    <div class="card-topo">
      <h2 class="titulo">{{ titulo }}</h2>
      <span class="codigo">#{{ codigo }}</span>
    </div>

    <div class="info-grid">
      <div class="info-box destaque">
        <span class="label">Urgência</span>
        <p :class="['urgencia', urgenciaClasse]">{{ urgenciaTexto }}</p>
      </div>

      <div class="info-box">
        <span class="label">Data</span>
        <p>{{ data }}</p>
      </div>

      <div class="info-box info-larga">
        <span class="label">Órgão</span>
        <p>{{ orgao }}</p>
      </div>

      <div class="info-box">
        <span class="label">Tipo</span>
        <p>{{ tipo }}</p>
      </div>
    </div>

    <div class="bloco-texto">
      <span class="label">Descrição</span>
      <div class="texto-scroll">
        {{ texto }}
      </div>
    </div>

    <div class="bloco-imagens">
      <div class="imagens-header">
        <span class="label">Imagens</span>
        <span class="contador">{{ imagens.length }} foto(s)</span>
      </div>

      <div v-if="imagens && imagens.length" class="lista-imagens">
        <div
            v-for="(imagem, index) in imagens"
            :key="index"
            class="imagem-item"
        >
          <img
              :src="imagem"
              :alt="`Imagem ${index + 1} da denúncia`"
          />
        </div>
      </div>

      <div v-else class="sem-imagens">
        Nenhuma imagem cadastrada.
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: "DenunciaCard",
  props: {
    titulo: {
      type: String,
      default: "Título da denúncia"
    },
    codigo: {
      type: [String, Number],
      default: "0000"
    },
    urgencia: {
      type: Number,
      default: 1
    },
    data: {
      type: String,
      default: "19/05/2026"
    },
    orgao: {
      type: String,
      default: "Órgão responsável"
    },
    tipo: {
      type: String,
      default: "Tipo da denúncia"
    },
    texto: {
      type: String,
      default: "Descrição da denúncia."
    },
    imagens: {
      type: Array,
      default: () => []
    }
  },
  computed: {
    urgenciaTexto() {
      const niveis = {
        1: "Baixa",
        2: "Média",
        3: "Alta",
        4: "Crítica"
      };
      return niveis[this.urgencia] || "Não informada";
    },
    urgenciaClasse() {
      const classes = {
        1: "baixa",
        2: "media",
        3: "alta",
        4: "critica"
      };
      return classes[this.urgencia] || "";
    }
  }
};
</script>

<style scoped>
.denuncia-card {
  width: 400px;
  max-width: 100%;
  background: #0a0a0a;
  border: 2px solid #f3e600;
  border-radius: 22px;
  padding: 20px;
  color: #f5f5f5;
  box-shadow: 0 0 0 1px rgba(243, 230, 0, 0.15), 0 12px 30px rgba(0, 0, 0, 0.45);
  display: flex;
  flex-direction: column;
  gap: 16px;
}

.card-topo {
  display: flex;
  justify-content: space-between;
  align-items: flex-start;
  gap: 12px;
}

.titulo {
  margin: 0;
  font-size: 22px;
  font-weight: 700;
  color: #f3e600;
  line-height: 1.2;
}

.codigo {
  background: #f3e600;
  color: #000;
  font-weight: 700;
  font-size: 13px;
  padding: 6px 10px;
  border-radius: 999px;
  white-space: nowrap;
}

.info-grid {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 12px;
}

.info-box {
  background: #121212;
  border: 1px solid rgba(243, 230, 0, 0.35);
  border-radius: 14px;
  padding: 12px;
}

.info-larga {
  grid-column: span 1;
}

.label {
  display: block;
  font-size: 11px;
  text-transform: uppercase;
  letter-spacing: 0.08em;
  color: #bdb76b;
  margin-bottom: 6px;
  font-weight: 700;
}

.info-box p,
.bloco-texto,
.sem-imagens,
.contador {
  margin: 0;
  font-size: 14px;
}

.destaque {
  background: linear-gradient(135deg, #1a1a1a 0%, #151515 100%);
}

.urgencia {
  font-weight: 700;
}

.urgencia.baixa {
  color: #7CFC00;
}

.urgencia.media {
  color: #ffd54f;
}

.urgencia.alta {
  color: #ff9800;
}

.urgencia.critica {
  color: #ff5252;
}

.bloco-texto {
  background: #121212;
  border: 1px solid rgba(243, 230, 0, 0.35);
  border-radius: 14px;
  padding: 12px;
}

.texto-scroll {
  max-height: 130px;
  overflow-y: auto;
  padding-right: 6px;
  line-height: 1.5;
  color: #e8e8e8;
}

.texto-scroll::-webkit-scrollbar {
  width: 6px;
}

.texto-scroll::-webkit-scrollbar-thumb {
  background: #f3e600;
  border-radius: 10px;
}

.bloco-imagens {
  background: #121212;
  border: 1px solid rgba(243, 230, 0, 0.35);
  border-radius: 14px;
  padding: 12px;
}

.imagens-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 10px;
}

.contador {
  color: #f3e600;
  font-size: 12px;
  font-weight: 600;
}

.lista-imagens {
  display: flex;
  gap: 12px;
  overflow-x: auto;
  scroll-snap-type: x mandatory;
  padding-bottom: 6px;
}

.lista-imagens::-webkit-scrollbar {
  height: 8px;
}

.lista-imagens::-webkit-scrollbar-thumb {
  background: #f3e600;
  border-radius: 999px;
}

.lista-imagens::-webkit-scrollbar-track {
  background: #1c1c1c;
  border-radius: 999px;
}

.imagem-item {
  min-width: 160px;
  height: 120px;
  flex-shrink: 0;
  scroll-snap-align: start;
  border-radius: 12px;
  overflow: hidden;
  border: 1px solid rgba(243, 230, 0, 0.4);
  background: #000;
}

.imagem-item img {
  width: 100%;
  height: 100%;
  object-fit: cover;
  display: block;
  transition: transform 0.25s ease;
}

.imagem-item img:hover {
  transform: scale(1.04);
}

.sem-imagens {
  min-height: 90px;
  display: flex;
  align-items: center;
  justify-content: center;
  border: 1px dashed rgba(243, 230, 0, 0.4);
  border-radius: 12px;
  color: #aaa;
  background: #0d0d0d;
}

@media (max-width: 480px) {
  .denuncia-card {
    width: 100%;
    padding: 16px;
  }

  .info-grid {
    grid-template-columns: 1fr;
  }

  .titulo {
    font-size: 20px;
  }

  .imagem-item {
    min-width: 140px;
    height: 110px;
  }
}
</style>