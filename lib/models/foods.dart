// Import the dart:convert library for JSON encoding and decoding functionality
import 'dart:convert';

// Top-level function to convert a JSON string into a List of FoodsModel objects
// Takes a JSON string as input and returns a List<FoodsModel>
List<FoodsModel> foodsModelFromJson(String str) => 
    // Create a List<FoodsModel> from the decoded JSON array
    List<FoodsModel>.from(
        // Decode the JSON string into a dynamic object (List or Map)
        json.decode(str)
            // Map each element (x) in the decoded array to a FoodsModel object
            .map((x) => FoodsModel.fromJson(x))
    );

// Top-level function to convert a List of FoodsModel objects into a JSON string
// Takes a List<FoodsModel> as input and returns a JSON string
String foodsModelToJson(List<FoodsModel> data) => 
    // Encode the list into a JSON string
    json.encode(
        // Convert the List<FoodsModel> into a List<dynamic> for JSON encoding
        List<dynamic>.from(
            // Map each FoodsModel object (x) to its JSON representation
            data.map((x) => x.toJson())
        )
    );

// Model class representing a food item with all its properties
class FoodsModel {
    // Unique identifier for the food item (from MongoDB _id)
    final String id;
    
    // Name/title of the food item
    final String title;
    
    // List of tags associated with the food (e.g., "spicy", "vegetarian")
    final List<String> foodTags;
    
    // List of food types/categories (e.g., "main course", "appetizer")
    final List<String> foodType;
    
    // Unique code identifier for the food item
    final String code;
    
    // Boolean flag indicating if the food is currently available for order
    final bool isAvailable;
    
    // ID or name of the restaurant offering this food
    final String restaurant;
    
    // Average rating of the food item (0.0 to 5.0)
    final double rating;
    
    // Number of ratings/reviews the food has received
    final String ratingCount;
    
    // Detailed description of the food item
    final String description;
    
    // Price of the food item
    final double price;
    
    // List of available add-ons or extras (e.g., extra cheese, toppings)
    final List<Additive> additives;
    
    // List of image URLs for the food item
    final List<String> imageUrl;
    
    // Category the food belongs to (e.g., "Pizza", "Burgers")
    final String category;
    
    // Estimated preparation/delivery time for the food
    final String time;

    // Constructor for FoodsModel with all required parameters
    FoodsModel({
        required this.id,           // id must be provided
        required this.title,        // title must be provided
        required this.foodTags,     // foodTags must be provided
        required this.foodType,     // foodType must be provided
        required this.code,         // code must be provided
        required this.isAvailable,  // isAvailable must be provided
        required this.restaurant,   // restaurant must be provided
        required this.rating,       // rating must be provided
        required this.ratingCount,  // ratingCount must be provided
        required this.description,  // description must be provided
        required this.price,        // price must be provided
        required this.additives,    // additives must be provided
        required this.imageUrl,     // imageUrl must be provided
        required this.category,     // category must be provided
        required this.time,         // time must be provided
    });

    // Factory constructor to create a FoodsModel instance from a JSON Map
    // Takes a Map<String, dynamic> and returns a FoodsModel object
    factory FoodsModel.fromJson(Map<String, dynamic> json) => FoodsModel(
        // Extract the "_id" field from JSON and assign to id
        id: json["_id"],
        
        // Extract the "title" field from JSON and assign to title
        title: json["title"],
        
        // Convert the "foodTags" JSON array to a List<String>
        foodTags: List<String>.from(json["foodTags"].map((x) => x)),
        
        // Convert the "foodType" JSON array to a List<String>
        foodType: List<String>.from(json["foodType"].map((x) => x)),
        
        // Extract the "code" field from JSON and assign to code
        code: json["code"],
        
        // Extract the "isAvailable" field from JSON and assign to isAvailable
        isAvailable: json["isAvailable"],
        
        // Extract the "restaurant" field from JSON and assign to restaurant
        restaurant: json["restaurant"],
        
        // Extract "rating" and convert to double (handles null with ?. operator)
        rating: json["rating"]?.toDouble(),
        
        // Extract the "ratingCount" field from JSON and assign to ratingCount
        ratingCount: json["ratingCount"],
        
        // Extract the "description" field from JSON and assign to description
        description: json["description"],
        
        // Extract "price" and convert to double (handles null with ?. operator)
        price: json["price"]?.toDouble(),
        
        // Convert the "additives" JSON array to a List<Additive>
        // Each element is mapped to an Additive object using Additive.fromJson
        additives: List<Additive>.from(json["additives"].map((x) => Additive.fromJson(x))),
        
        // Convert the "imageUrl" JSON array to a List<String>
        imageUrl: List<String>.from(json["imageUrl"].map((x) => x)),
        
        // Extract the "category" field from JSON and assign to category
        category: json["category"],
        
        // Extract the "time" field from JSON and assign to time
        time: json["time"],
    );

    // Method to convert the FoodsModel instance to a JSON Map
    // Returns a Map<String, dynamic> representing the object
    Map<String, dynamic> toJson() => {
        // Map the id property to the "_id" JSON key
        "_id": id,
        
        // Map the title property to the "title" JSON key
        "title": title,
        
        // Convert the foodTags List<String> to a List<dynamic> for JSON
        "foodTags": List<dynamic>.from(foodTags.map((x) => x)),
        
        // Convert the foodType List<String> to a List<dynamic> for JSON
        "foodType": List<dynamic>.from(foodType.map((x) => x)),
        
        // Map the code property to the "code" JSON key
        "code": code,
        
        // Map the isAvailable property to the "isAvailable" JSON key
        "isAvailable": isAvailable,
        
        // Map the restaurant property to the "restaurant" JSON key
        "restaurant": restaurant,
        
        // Map the rating property to the "rating" JSON key
        "rating": rating,
        
        // Map the ratingCount property to the "ratingCount" JSON key
        "ratingCount": ratingCount,
        
        // Map the description property to the "description" JSON key
        "description": description,
        
        // Map the price property to the "price" JSON key
        "price": price,
        
        // Convert the additives List<Additive> to a List<dynamic> for JSON
        // Each Additive object is converted to JSON using its toJson method
        "additives": List<dynamic>.from(additives.map((x) => x.toJson())),
        
        // Convert the imageUrl List<String> to a List<dynamic> for JSON
        "imageUrl": List<dynamic>.from(imageUrl.map((x) => x)),
        
        // Map the category property to the "category" JSON key
        "category": category,
        
        // Map the time property to the "time" JSON key
        "time": time,
    };
}

// Model class representing an additive/add-on item for a food
class Additive {
    // Unique identifier for the additive
    final int id;
    
    // Name/title of the additive (e.g., "Extra Cheese", "Bacon")
    final String title;
    
    // Price of the additive as a string
    final String price;

    // Constructor for Additive with all required parameters
    Additive({
        required this.id,     // id must be provided
        required this.title,  // title must be provided
        required this.price,  // price must be provided
    });

    // Factory constructor to create an Additive instance from a JSON Map
    // Takes a Map<String, dynamic> and returns an Additive object
    factory Additive.fromJson(Map<String, dynamic> json) => Additive(
        // Extract the "id" field from JSON and assign to id
        id: json["id"],
        
        // Extract the "title" field from JSON and assign to title
        title: json["title"],
        
        // Extract the "price" field from JSON and assign to price
        price: json["price"],
    );

    // Method to convert the Additive instance to a JSON Map
    // Returns a Map<String, dynamic> representing the object
    Map<String, dynamic> toJson() => {
        // Map the id property to the "id" JSON key
        "id": id,
        
        // Map the title property to the "title" JSON key
        "title": title,
        
        // Map the price property to the "price" JSON key
        "price": price,
    };
}
