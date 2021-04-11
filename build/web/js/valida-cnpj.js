function validaCNPJ(cnpj) {
    cnpj = cnpj.replaceAll(".", "");
    cnpj = cnpj.replaceAll("-", "");

    if ((cnpj == "00000000000") || (cnpj == "11111111111") || (cnpj == "22222222222") 
        || (cnpj == "33333333333") || (cnpj == "44444444444") || (cnpj == "55555555555") 
        || (cnpj == "66666666666") || (cnpj == "77777777777") || (cnpj == "88888888888") 
        || (cnpj == "99999999999"))
        return false;
    return true;
}