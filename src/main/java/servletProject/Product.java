
package servletProject;

public class Product {
    private int id;
    private String name;
    private String description;
    private double price;
    private String image;
    
    public Product(int id, String name, String description, double price, String image) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.price = price;
        this.image = image;
    }

    
    public Product() {
		// TODO Auto-generated constructor stub
	}




	public void setId(int id) { this.id = id; }
    public void setName(String name) { this.name = name; }
    public void setDescription(String description) { this.description = description; }
    public void setPrice(double price) { this.price = price; }
    public void setImage(String image) { this.image = image; }
    
    
    // Getters
    public int getId() { return id; }
    public String getName() { return name; }
    public String getDescription() { return description; }
    public double getPrice() { return price; }
    public String getImage() { return image; }


}

