<template>
  <div class="page-decor">
    <div class="page-side page-side--left">
      <StripSlideVertical height="100%" />
    </div>
    <div class="page-side page-side--right">
      <StripSlideVertical height="100%" />
    </div>
  </div>

  <section class="citizen-page">
    <div class="page-glow page-glow--left"></div>
    <div class="page-glow page-glow--right"></div>

    <header class="topbar">
      <div class="topbar__brand">
        <div class="brand-mark">
          <img src="../../public/logoPeralta.png" alt="Logo" />
        </div>
        <div class="brand-copy">
          <span class="brand-name">Peralta 99</span>
          <span class="brand-subtitle">Painel do administrador</span>
        </div>
      </div>

      <nav class="topbar__nav">
        <button class="nav-link" type="button" @click="$router.push('/admin')">
          Gerenciar Denúncias
        </button>
        <button class="nav-link" type="button" @click="$router.push('/admin/orgaos')">
          Gerenciar Órgãos
        </button>
      </nav>

      <button class="danger-action" type="button" @click="logout">Deslogar</button>
    </header>

    <section class="hero-panel">
      <span class="eyebrow">Painel do administrador</span>
      <h1>Gerenciamento de tipos de problemas</h1>
      <p>
        Consulte os tipos de problemas cadastrados, busque por ID ou nome e realize alterações ou exclusões diretamente pela tabela.
      </p>
    </section>

    <section class="toolbar-shell">
      <div class="toolbar-panel">
        <div class="search-container">
          <InputText
              id="search-orgao"
              :modelValue="busca"
              placeholder="Buscar por ID ou nome do problema"
              @update:modelValue="atualizarBusca"
          >
            <template #icon>
              <svg viewBox="0 0 24 24" aria-hidden="true" class="search-icon">
                <path d="M10.5 18a7.5 7.5 0 1 1 5.303-2.197L21 21" />
              </svg>
            </template>
          </InputText>
        </div>

        <div class="toolbar-right">
          <button class="primary-action" type="button" @click="abrirNovoTipo">
            Novo Problema
          </button>
        </div>
      </div>
    </section>

    <section class="reports-shell">
      <div class="section-heading">
        <div>
          <span class="section-kicker">Cadastros</span>
          <h2>Problemas cadastrados</h2>
        </div>
        <span class="section-caption">
          Visualização administrativa dos Problemas registrados
        </span>
      </div>

      <div v-if="listaFiltrada.length > 0" class="table-shell">
        <table class="orgao-table">
          <thead>
          <tr>
            <th>ID</th>
            <th>Nome</th>
            <th class="acoes-col">Ações</th>
          </tr>
          </thead>
          <tbody>
          <tr v-for="tipo in listaFiltrada" :key="tipo.id">
            <td class="td-id">#{{ tipo.id }}</td>
            <td class="td-nome">{{ tipo.nome }}</td>
            <td class="td-actions">
              <button
                  class="table-action table-action--edit"
                  type="button"
                  @click="editarTipo(tipo)"
              >
                Alterar
              </button>
              <button
                  class="table-action table-action--delete"
                  type="button"
                  @click="confirmarDelecao(tipo)"
              >
                Excluir
              </button>
            </td>
          </tr>
          </tbody>
        </table>
      </div>

      <div v-else class="feedback-hint">
        Nenhum tipo de problema foi encontrado. Ajuste a busca ou cadastre um novo tipo.
      </div>
    </section>

    <Form
        :show="showForm"
        :title="modoEdicao ? 'Editar tipo de problema' : 'Novo tipo'"
        :schema="formSchema"
        :initial-data="tipoSelecionado"
        @close="fecharForm"
        @confirm="salvarTipo"
    />
  </section>
</template>

<script>
import api from '../service/api.js';
import Form from "../components/forms/Form.vue";
import InputText from "../components/forms/InputText.vue";
import StripSlideVertical from "../components/ui/StripSlideVertical.vue";
import Validator from "../utils/Validator.js";

export default
{
  name: "AdminTiposView",
  components:
      {
        StripSlideVertical,
        Form,
        InputText
      },
  data()
  {
    return {
      showModal: false,
      showForm: false,
      listaTipos: [],
      listaFiltrada: [],
      busca: '',
      modoEdicao: false,
      tipoSelecionado: null
    };
  },
  computed:
      {
        formSchema()
        {
          return [
            {
              fields:
                  [
                    {
                      name: "nome",
                      label: "Nome do tipo de problema",
                      type: "text",
                      placeholder: "Digite o nome do tipo de problema",
                      validator: Validator.required,
                      required: true
                    }
                  ]
            }
          ];
        }
      },
  methods:
      {
        atualizarBusca(valor)
        {
          this.busca = valor;
          this.aplicarFiltros();
        },

        aplicarFiltros()
        {
          let lista = [...this.listaTipos];

          if (this.busca?.trim())
          {
            const termo = this.busca.toLowerCase().trim();

            lista = lista.filter(tipo =>
                String(tipo?.id || '').includes(termo) ||
                tipo?.nome?.toLowerCase().includes(termo)
            );
          }

          this.listaFiltrada = lista;
        },

        abrirNovoTipo()
        {
          this.modoEdicao = false;
          this.tipoSelecionado = null;
          this.showForm = true;
        },

        editarTipo(tipo)
        {
          this.modoEdicao = true;
          this.tipoSelecionado = { ...tipo };
          this.showForm = true;
        },

        fecharForm()
        {
          this.showForm = false;
          this.modoEdicao = false;
          this.tipoSelecionado = null;
        },

        async buscarTipos()
        {
          await api.get("/apis/admin/all-types")
              .then(response =>
              {
                if (response.status === 200)
                {
                  this.listaTipos = response.data;
                  this.listaTipos.sort((a, b) => a.id - b.id);
                  console.log(this.listaTipos);
                  this.aplicarFiltros();
                }
                else
                {
                  this.$toast.error("Erro ao carregar os tipos de problemas. Tente novamente mais tarde.");
                }
              })
              .catch(() =>
              {
                this.$toast.error("Erro ao carregar os tipos de problemas. Tente novamente mais tarde.");
              });
        },

        async salvarTipo(formDados)
        {
          try
          {

            let response = null;

            if (this.modoEdicao && this.tipoSelecionado?.id)
            {
              const payload =
                  {
                    nome: formDados.nome,
                    id: this.tipoSelecionado?.id
                  };

              response = await api.put(`/apis/admin/update-type`, payload);
            }
            else
            {
              const payload =
                  {
                    nome: formDados.nome,
                  };
              response = await api.post("/apis/admin/add-type", payload);
            }

            if (response.status === 200 || response.status === 201)
            {
              this.$toast.success(this.modoEdicao ? "Tipo atualizado com sucesso!" : "Tipo cadastrado com sucesso!");
              this.fecharForm();
              await this.buscarTipos();
            }
          }
          catch (error)
          {
            this.$toast.error(this.modoEdicao ? "Erro ao atualizar o tipo." : "Erro ao cadastrar o tipo.");
          }
        },

        confirmarDelecao(tipo)
        {
          api.delete(`/apis/admin/delete-type/${tipo.id}`)
              .then(response =>
              {
                if (response.status === 200)
                {
                  this.$toast.success(`O tipo "${tipo.nome}" foi deletado com sucesso!`);
                  this.buscarOrgaos();
                }
              })
              .catch(() =>
              {
                this.$toast.error("Ocorreu um erro ao deletar o tipo.");
              });
        },

        logout()
        {
          localStorage.removeItem("Authorization");
          localStorage.removeItem("usuario");
          this.$router.push("/login");
        }
      },
  async mounted()
  {
    try
    {
      const usuario = JSON.parse(localStorage.getItem("usuario") || "null");
      const token = localStorage.getItem("Authorization");

      if (!usuario || !usuario.id || !token)
      {
        throw new Error("Usuário ou token ausente");
      }
      else if (usuario.nivel != 1)
      {
        throw new Error("Não autorizado");
      }

      await this.buscarTipos();
    }
    catch (error)
    {
      localStorage.removeItem("Authorization");
      localStorage.removeItem("usuario");
      this.$toast.error("Faça login para acessar o painel do administrador novamente.");
      this.$router.push("/login");
    }
  }
};
</script>

<style scoped>
.citizen-page
{
  --bg: #050507;
  --bg-2: #0a0a0f;
  --panel: rgba(14, 14, 18, 0.88);
  --panel-strong: rgba(18, 18, 24, 0.96);
  --panel-soft: rgba(255, 255, 255, 0.03);
  --border: rgba(255, 255, 255, 0.08);
  --text: #f5f5f7;
  --text-soft: #c8c8d1;
  --text-muted: #8e8e99;
  --yellow: #f3df13;
  --red: #ff4d57;
  --blue: #63b3ed;
  min-height: 100vh;
  padding: 28px;
  color: var(--text);
  position: relative;
  overflow: hidden;
  display: grid;
  z-index: 1;
  gap: 28px;
  background: transparent;
}

.page-glow
{
  position: absolute;
  width: 360px;
  height: 360px;
  border-radius: 999px;
  filter: blur(90px);
  opacity: 0.22;
  pointer-events: none;
}

.page-glow--left
{
  top: -90px;
  left: -120px;
  background: rgba(141, 120, 255, 0.18);
}

.page-glow--right
{
  top: 40px;
  right: -100px;
  background: rgba(243, 223, 19, 0.08);
}

.topbar
{
  position: relative;
  z-index: 1;
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 24px;
  padding: 16px 22px;
  background: linear-gradient(180deg, rgba(14, 14, 18, 0.88), rgba(10, 10, 14, 0.74));
  border: 1px solid var(--border);
  border-radius: 24px;
  backdrop-filter: blur(14px);
}

.topbar__brand
{
  display: flex;
  align-items: center;
  gap: 14px;
}

.brand-mark img
{
  width: 72px;
  height: 56px;
  opacity: 0.8;
}

.brand-copy
{
  display: grid;
  gap: 2px;
}

.brand-name
{
  font-size: 1.1rem;
  font-weight: 800;
  letter-spacing: 0.03em;
}

.brand-subtitle
{
  color: var(--text-muted);
  font-size: 0.82rem;
}

.topbar__nav
{
  display: flex;
  gap: 10px;
  flex-wrap: wrap;
}

.nav-link
{
  min-height: 42px;
  padding: 0 16px;
  border: 1px solid transparent;
  border-radius: 999px;
  background: transparent;
  color: var(--text-soft);
  font-size: 0.92rem;
  font-weight: 700;
  cursor: pointer;
  transition: 180ms ease;
}

.nav-link:hover
{
  background: rgba(255, 255, 255, 0.04);
  color: var(--yellow);
  border-color: rgba(243, 223, 19, 0.18);
}

.danger-action
{
  min-height: 42px;
  padding: 0 16px;
  border-radius: 999px;
  border: 1px solid rgba(255, 77, 87, 0.34);
  background: rgba(255, 77, 87, 0.06);
  color: var(--red);
  font-size: 0.92rem;
  font-weight: 800;
  cursor: pointer;
  transition: 180ms ease;
}

.danger-action:hover
{
  background: rgba(255, 77, 87, 0.8);
  color: #0a0a0a;
}

.hero-panel
{
  position: relative;
  z-index: 1;
  display: grid;
  gap: 14px;
}

.eyebrow,
.section-kicker
{
  display: inline-flex;
  align-items: center;
  gap: 8px;
  color: var(--yellow);
  font-size: 0.8rem;
  font-weight: 800;
  letter-spacing: 0.12em;
  text-transform: uppercase;
}

.hero-panel h1
{
  margin: 0;
  font-size: clamp(3rem, 6vw, 5rem);
  line-height: 0.94;
  letter-spacing: -0.05em;
  font-weight: 900;
}

.hero-panel p
{
  margin: 0;
  max-width: 64ch;
  color: var(--text-soft);
  font-size: 1rem;
  line-height: 1.75;
}

.toolbar-shell
{
  position: relative;
  z-index: 1;
}

.toolbar-panel
{
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 16px;
  padding: 18px;
  background: linear-gradient(180deg, rgba(15, 15, 20, 0.92), rgba(10, 10, 14, 0.94));
  border: 1px solid rgba(255, 255, 255, 0.07);
  border-radius: 26px;
}

.search-container
{
  flex: 1;
}

.toolbar-right
{
  display: flex;
  align-items: center;
  gap: 12px;
}

.search-icon
{
  width: 18px;
  height: 18px;
  stroke: var(--yellow);
  stroke-width: 2;
  fill: none;
}

.primary-action
{
  min-height: 46px;
  padding: 0 18px;
  border-radius: 16px;
  font-size: 0.9rem;
  font-weight: 800;
  cursor: pointer;
  transition: 180ms ease;
  border: 1px solid rgba(243, 223, 19, 0.34);
  background: linear-gradient(180deg, #f3df13, #dbc500);
  color: #0a0a0a;
}

.primary-action:hover
{
  transform: translateY(-1px);
}

.reports-shell
{
  display: grid;
  gap: 18px;
  padding: 22px;
  background: linear-gradient(180deg, rgba(14, 14, 18, 0.90), rgba(10, 10, 14, 0.96));
  border: 1px solid rgba(255, 255, 255, 0.07);
  border-radius: 28px;
}

.section-heading
{
  display: flex;
  align-items: flex-end;
  justify-content: space-between;
  gap: 16px;
}

.section-heading h2
{
  margin: 6px 0 0;
  font-size: clamp(1.8rem, 3vw, 2.5rem);
  line-height: 1;
  letter-spacing: -0.04em;
}

.section-caption
{
  color: var(--text-muted);
  font-size: 0.9rem;
}

.table-shell
{
  overflow-x: auto;
  border-radius: 22px;
  border: 1px solid rgba(255, 255, 255, 0.06);
  background: linear-gradient(180deg, rgba(18, 18, 24, 0.72), rgba(11, 11, 16, 0.88));
}

.orgao-table
{
  width: 100%;
  min-width: 720px;
  border-collapse: collapse;
}

.orgao-table thead tr
{
  background: rgba(255, 255, 255, 0.03);
}

.orgao-table th
{
  padding: 16px 18px;
  text-align: left;
  font-size: 0.78rem;
  letter-spacing: 0.08em;
  text-transform: uppercase;
  color: var(--text-muted);
  border-bottom: 1px solid rgba(255, 255, 255, 0.08);
}

.orgao-table td
{
  padding: 16px 18px;
  border-bottom: 1px solid rgba(255, 255, 255, 0.06);
  color: var(--text-soft);
  vertical-align: middle;
}

.orgao-table tbody tr
{
  transition: background 180ms ease;
}

.orgao-table tbody tr:hover
{
  background: rgba(255, 255, 255, 0.025);
}

.td-id
{
  color: #ddd7ff;
  font-weight: 800;
  width: 120px;
}

.td-nome
{
  font-weight: 700;
}

.acoes-col
{
  width: 220px;
}

.td-actions
{
  display: flex;
  gap: 10px;
  flex-wrap: wrap;
}

.table-action
{
  min-height: 38px;
  padding: 0 14px;
  border-radius: 12px;
  border: 1px solid transparent;
  font-size: 0.78rem;
  font-weight: 800;
  letter-spacing: 0.04em;
  text-transform: uppercase;
  cursor: pointer;
}

.table-action--edit
{
  background: rgba(99, 179, 237, 0.10);
  color: var(--blue);
  border-color: rgba(99, 179, 237, 0.18);
}

.table-action--edit:hover
{
  background: rgba(99, 179, 237, 0.18);
}

.table-action--delete
{
  background: rgba(255, 102, 113, 0.08);
  color: #ff6671;
  border-color: rgba(255, 102, 113, 0.18);
}

.table-action--delete:hover
{
  background: rgba(255, 102, 113, 0.16);
}

.feedback-hint
{
  min-height: 220px;
  display: grid;
  place-items: center;
  padding: 24px;
  border-radius: 22px;
  border: 1px dashed rgba(141, 120, 255, 0.26);
  background: linear-gradient(180deg, rgba(141, 120, 255, 0.05), rgba(141, 120, 255, 0.03));
  color: #ddd7ff;
  text-align: center;
  font-weight: 700;
}

.page-decor
{
  position: fixed;
  inset: 0;
  pointer-events: none;
  z-index: 0;
  overflow: hidden;
}

.page-side
{
  position: absolute;
  top: 0;
  height: 100vh;
  width: 84px;
  opacity: 0.18;
  filter: blur(6px);
}

.page-side--left
{
  left: -18px;
}

.page-side--right
{
  right: -18px;
  transform: scaleX(-1);
}

@media (max-width: 1100px)
{
  .topbar
  {
    flex-direction: column;
    align-items: stretch;
  }

  .topbar__nav
  {
    justify-content: flex-start;
  }

  .toolbar-panel
  {
    flex-direction: column;
    align-items: stretch;
  }

  .search-container
  {
    max-width: 100%;
  }

  .toolbar-right
  {
    width: 100%;
  }

  .primary-action
  {
    width: 100%;
  }
}

@media (max-width: 720px)
{
  .citizen-page
  {
    padding: 18px;
  }

  .hero-panel h1
  {
    font-size: clamp(2.2rem, 10vw, 3.2rem);
  }

  .orgao-table
  {
    min-width: 640px;
  }
}
</style>