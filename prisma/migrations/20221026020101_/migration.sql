/*
  Warnings:

  - The primary key for the `TrackedArtist` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `id` on the `TrackedArtist` table. All the data in the column will be lost.
  - Added the required column `assignedBy` to the `TrackedArtist` table without a default value. This is not possible if the table is not empty.
  - Made the column `userId` on table `TrackedArtist` required. This step will fail if there are existing NULL values in that column.
  - Made the column `artistId` on table `TrackedArtist` required. This step will fail if there are existing NULL values in that column.

*/
-- DropForeignKey
ALTER TABLE "TrackedArtist" DROP CONSTRAINT "TrackedArtist_artistId_fkey";

-- DropForeignKey
ALTER TABLE "TrackedArtist" DROP CONSTRAINT "TrackedArtist_userId_fkey";

-- AlterTable
ALTER TABLE "TrackedArtist" DROP CONSTRAINT "TrackedArtist_pkey",
DROP COLUMN "id",
ADD COLUMN     "assignedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "assignedBy" TEXT NOT NULL,
ALTER COLUMN "userId" SET NOT NULL,
ALTER COLUMN "artistId" SET NOT NULL,
ADD CONSTRAINT "TrackedArtist_pkey" PRIMARY KEY ("userId", "artistId");

-- AddForeignKey
ALTER TABLE "TrackedArtist" ADD CONSTRAINT "TrackedArtist_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TrackedArtist" ADD CONSTRAINT "TrackedArtist_artistId_fkey" FOREIGN KEY ("artistId") REFERENCES "Artist"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
