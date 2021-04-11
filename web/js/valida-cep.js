function validaCEP(cep) {

    cep = cep.replaceAll(".", "");
    cep = cep.replaceAll("-", "");

    return true;

}