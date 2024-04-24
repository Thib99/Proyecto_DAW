package tienda;


public class CardBD {

    private String card_number ;
    private int  persona ;
    private String exp_date ;
    private String cvv ;
    private String card_name ;
    private int codigo ;

    public String getCard_number() {
        return card_number;
    }
    public String getCard_number_masked() {
        return "**** **** **** " + card_number.substring(12, 16);
    }
    public void setCard_number(String card_number) {
        this.card_number = card_number;
    }
    public int getPersona() {
        return persona;
    }
    public void setPersona(int persona) {
        this.persona = persona;
    }
    public String getExp_date() {
        return exp_date;
    }
    public void setExp_date(String exp_date) {
        this.exp_date = exp_date;
    }
    public String getCvv() {
        return cvv;
    }
    public void setCvv(String cvv) {
        this.cvv = cvv;
    }
    public String getCard_name() {
        return card_name;
    }
    public void setCard_name(String card_name) {
        this.card_name = card_name;
    }
    public int getCodigo() {
        return codigo;
    }
    public void setCodigo(int codigo) {
        this.codigo = codigo;
    }


  
    
}
