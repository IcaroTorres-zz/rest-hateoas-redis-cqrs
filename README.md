# rest-hateoas-redis-cqrs

> Simple .net core rest apis with basic implementation of *CQRS* + *repository and unit of work* + *hateoas output* + *redis cache*

## CQRS - _Command and Query Responsibility Segregation_

> Pattern responsible for segregate operations in two groups of concerns:

- Perform *Commands* and logic to alter data statuses and values;
- Structures prepared to *Query* data as is.

## Repository and Unit of Work

> Strablished Enterprise Patterns applied in data access layers:

- Repository for abstractions of data sources implementating data access and manipulation;
- Unit of Work as database transaction handler and database command emitter.

## Hateoas - _Hypermedia As The Engine Of Application State_

> Is a component of the REST application architecture that distinguishes it from other network application architectures.
> With HATEOAS, a client interacts with a network application whose application servers provide information dynamically through hypermedia.

## Cache - Using Redis

> Caching is the ability to store copies of frequently accessed data in several places along the request-response path.

- The goal of caching is never having to generate the same response twice. The benefit of doing this is that we gain speed and reduce server load;
- Redis is an open source (BSD licensed), in-memory data structure store, used as a database, cache and message broker.
