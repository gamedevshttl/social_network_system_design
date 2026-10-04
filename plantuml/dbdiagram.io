@startuml
!include https://raw.githubusercontent.com/plantuml-stdlib/C4-PlantUML/master/C4_Container.puml

Person(traveler, "Traveler", "Publishes posts and reads the feed")

System_Boundary(social_network, "Social Network For Travelers") {
    Container(client, "Client App", "iOS / Android / React", "Publishing posts, feed, places")

    Container(api_gateway, "API Gateway", "iOS / Android / React", "Publishing posts, feed, places")
    Container(post_service, "Post Service", "Node.js", "Posts, feed, places")
    Container(user_service, "User Service", "Node.js", "User, subscriptions")
    Container(reaction_service, "Reaction Service", "Node.js", "Likes, comments")
    Container(media_storage_service, "Media Storage Service", "Node.js", "S3")

    ContainerDb(postgres, "PostgreSQL", "PostgreSQL 16 + PostGIS", "Posts, comments, likes, users, places")
    ContainerDb(media_storage, "Media Storage", "S3-compatible")
}


Rel(traveler, client, "Uses", "HTTPS")

Rel(client, api_gateway, "API request", "JSON/HTTPS")

Rel(api_gateway, post_service, "Posts, feeds search", "JSON/HTTPS")
Rel(api_gateway, user_service, "User, subscription", "JSON/HTTPS")
Rel(api_gateway, reaction_service, "Likes, comments", "JSON/HTTPS")
Rel(post_service, media_storage_service, "Get/put image", "JSON/HTTPS")


Rel(media_storage_service, media_storage, "Stores originals", "S3 API")
Rel(media_storage_service, postgres, "Writes photo metadata", "SQL")

Rel(post_service, postgres, "Writes/read post", "SQL")
Rel(user_service, postgres, "Writes/read user, sbscription", "SQL")
Rel(reaction_service, postgres, "Writes/read comments, like", "SQL")
@enduml