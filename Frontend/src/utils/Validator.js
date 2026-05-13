export default class Validator
{
    static required(value)
    {
        return value?.toString().trim().length > 0
    }

    static email(value = '')
    {
        return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(value)
    }

    static phone(value = '')
    {
        const digits = value.replace(/\D/g, '');

        if (digits.length < 10 || digits.length > 11)
            return false;

        if (/^(\d)\1+$/.test(digits))
            return false;

        const ddd = parseInt(digits.substring(0, 2));

        if (ddd < 11 || ddd > 99)
            return false;

        return true;
    }

    static min(length = 3)
    {
        return (value = '') =>
        {
            return value.length >= length
        }
    }

    static max(length = 10)
    {
        return (value = '') => { return value.length <= length; }
    }

    static cpf(value = '')
    {
        value = value.replace(/\D/g, '');

        if (value.length !== 11)
            return false;

        if (/^(\d)\1+$/.test(value))
            return false;

        let sum = 0;

        for (let i = 0; i < 9; i++)
            sum += Number(value[i]) * (10 - i);

        let first = (sum * 10) % 11;

        if (first === 10)
            first = 0;

        if (first !== Number(value[9]))
            return false;

        sum = 0;

        for (let i = 0; i < 10; i++)
            sum += Number(value[i]) * (11 - i);

        let second = (sum * 10) % 11;

        if (second === 10)
            second = 0;

        return second === Number(value[10]);
    }

    static cep(value = '')
    {
        return value.replace(/\D/g, '').length === 8
    }
}