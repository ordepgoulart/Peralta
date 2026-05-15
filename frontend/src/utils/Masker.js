export default class Masker
{
    static only_numbers(value = '')
    {
        return value.replace(/\D/g, '')
    }

    static cpf(value = '')
    {
        value = Masker.only_numbers(value)

        return value
            .replace(/(\d{3})(\d)/, '$1.$2')
            .replace(/(\d{3})(\d)/, '$1.$2')
            .replace(/(\d{3})(\d{1,2})$/, '$1-$2')
            .slice(0, 14)
    }

    static phone(value = '')
    {
        value = Masker.only_numbers(value)

        if (value.length <= 10)
        {
            return value
                .replace(/^(\d{2})(\d)/, '($1) $2')
                .replace(/(\d{4})(\d)/, '$1-$2')
                .slice(0, 14)
        }

        return value
            .replace(/^(\d{2})(\d)/, '($1) $2')
            .replace(/(\d{5})(\d)/, '$1-$2')
            .slice(0, 15)
    }

    static cep(value = '')
    {
        value = Masker.only_numbers(value)

        return value
            .replace(/^(\d{5})(\d)/, '$1-$2')
            .slice(0, 9)
    }

    static currency(value = '')
    {
        value = Masker.only_numbers(value)

        return new Intl.NumberFormat('pt-BR',
            {
                style: 'currency',
                currency: 'BRL'
            }).format(value / 100)
    }
}