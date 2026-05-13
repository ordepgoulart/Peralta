<script setup>
    import { ref } from "vue";

    import Header from "../components/layout/Header.vue";
    import Footer from "../components/layout/Footer.vue";

    import RowDivision from "../components/forms/RowDivision.vue";
    import InputText from "../components/forms/Inputs/InputText.vue";
    import InputFile from "../components/forms/Inputs/InputFile.vue";
    import Button from "../components/forms/Button.vue";
    import StripSlide from "../components/attachment/StripSlide.vue";

    import Validator from "../utils/Validator.js";
    import Masker from "../utils/Masker.js";

    const name = ref('');
    const phone = ref('');
    const cpf = ref('');
    const cep = ref('');
    const email = ref('');
</script>

<template>
    <Header />

    <main id="center">
        <div class="form-container">
            <StripSlide height="30px" class="spacer" />

            <h1 class="title">Registrar denuncias</h1>

            <RowDivision cols="2">
                <InputText v-model="name" :validator="Validator.min(3)" label="Nome" placeholder="Seu nome completo" />
                <InputText v-model="phone" :mask="Masker.phone" :validator="Validator.phone" label="Telefone" placeholder="(00) 00000-0000"/>
            </RowDivision>

            <RowDivision cols="2">
                <InputText v-model="cpf" :mask="Masker.cpf" :validator="Validator.cpf" label="Cpf" placeholder="000.000.000-00"/>
                <InputText v-model="cep" :mask="Masker.cep" :validator="Validator.cep" label="Cep" placeholder="00000-000" />
            </RowDivision>

            <RowDivision cols="1">
                <InputText v-model="email" :validator="Validator.email" label="Email" placeholder="seu-email@email.com" />
            </RowDivision>

            <RowDivision cols="1">
                <InputFile />
            </RowDivision>

            <RowDivision cols="1">
                <Button>Enviar Relatório</Button>
            </RowDivision>
        </div>
    </main>

    <Footer />
</template>

<style scoped>
    #center
    {
        flex: 1;
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
        padding: 40px 20px;
    }

    .form-container
    {
        width: 100%;
        max-width: 800px;
        padding: 2rem;
        border-radius: 15px;
        display: flex;
        flex-direction: column;
        gap: 1rem;
        border: 1px solid var(--border);
    }

    .spacer
    {
        margin-bottom: 2rem;
    }
</style>