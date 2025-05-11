## 🎯 Objective
The goal is to optimize the database design, applying normalization principles to ensure the database is in the third normal form (3NF).

## ✨ Optimizations
### From the `Properties` table
| PropertyID | PropertyName | Description | Location | PricePerNight($) | Media |
| --- | --- | --- | --- | --- | --- |
| 101 | Beach House | Enjoy the cool luxury of ... | Baru Island, Colombia | 150 | /media/living-room.png, /media/bed-room-01.png, /media/bed-room-02.mp4 |

Properties may optionally have media files like the images of the property and video tours for advertisement. This data is stored as a string of comma-separated paths pointing to the location of the file in the file system or over the network via HTTP.
While this may seem convinient at first glance, it violates 1NF, leading to redundancies and anomalies that makes managing the database unefficient
#### Why this is a problem
- **Difficulty in updating:** If a particular media file was to be created or deleted, it would require complex string manipulations to update the string. This is error-prone and may lead to inconsistencies in the database. SQL is designed to work with individual data in columns.
- **Difficulty in usage:** With every media path concatenated into a string, it would be difficult to know the type of a file. This would require additional validation logic to know the type of a file for proper use.
#### Solution
To solve this, a new table has to be created for media data. This way, individual media can be created, deleted or used without being vulnerable to anomalies.

**`Properties` Table**
| PropertyID | PropertyName | Description | Location | PricePerNight($) |
| --- | --- | --- | --- | --- |
| 101 | Beach House | Enjoy the cool luxury of ... | Baru Island, Colombia | 150 |
| 102 | Maspalomas | Newly renovated, facing sea... | Spain | 200 |

**`Medias` Table**
| MediaID | PropertyID FK | Path | Type |
| --- | --- | --- | --- |
| M1 | 101 | /media/living-room.png | image |
| M2 | 101 | /media/bed-room-02.mp4 | video |
| M3 | 102 | /media/lounge.png | image |
| M4 | 102 | /media/kitchen.png | image |
| M5 | 102 | /media/virtual-tour.mp4 | video |

By decomposing the Properties table into two independent tables: `Properties` table and `Medias` table, individual media can be created, deleted, or utilized without affecting the database, having foreign key `Medias[PropertyID]` maintain the relationship (one-to-many) between properties and their media.

### ✅ This adheres to normalization principles up to the third normal form
- **1NF:** All cells contains atomic values.
- **2NF:** All non-key attributes are fully functionally dependent on the primary key.
- **3NF:** All non-key attributes are directly dependent on the primary key, there are no transitive dependencies.