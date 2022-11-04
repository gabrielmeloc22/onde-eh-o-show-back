/*
  Warnings:

  - You are about to drop the `ArtistNotification` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "ArtistNotification" DROP CONSTRAINT "ArtistNotification_artistId_fkey";

-- DropForeignKey
ALTER TABLE "ArtistNotification" DROP CONSTRAINT "ArtistNotification_configId_fkey";

-- DropTable
DROP TABLE "ArtistNotification";
