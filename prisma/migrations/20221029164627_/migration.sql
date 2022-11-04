-- DropIndex
DROP INDEX "Config_id_key";

-- AlterTable
ALTER TABLE "Config" ADD CONSTRAINT "Config_pkey" PRIMARY KEY ("id");
