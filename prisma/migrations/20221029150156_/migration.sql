/*
  Warnings:

  - You are about to drop the column `userId` on the `Config` table. All the data in the column will be lost.

*/
-- DropForeignKey
ALTER TABLE "Config" DROP CONSTRAINT "Config_userId_fkey";

-- DropIndex
DROP INDEX "Config_userId_key";

-- AlterTable
ALTER TABLE "Config" DROP COLUMN "userId";

-- CreateTable
CREATE TABLE "UserConfig" (
    "userId" TEXT NOT NULL,
    "configId" TEXT NOT NULL,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "UserConfig_pkey" PRIMARY KEY ("userId","configId")
);

-- CreateIndex
CREATE UNIQUE INDEX "UserConfig_userId_key" ON "UserConfig"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "UserConfig_configId_key" ON "UserConfig"("configId");

-- AddForeignKey
ALTER TABLE "UserConfig" ADD CONSTRAINT "UserConfig_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UserConfig" ADD CONSTRAINT "UserConfig_configId_fkey" FOREIGN KEY ("configId") REFERENCES "Config"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
