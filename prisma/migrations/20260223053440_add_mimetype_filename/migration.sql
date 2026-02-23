-- CreateTable
CREATE TABLE "User" (
    "id" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "role" TEXT NOT NULL DEFAULT 'EMPLOYEE',
    "department" TEXT,
    "position" TEXT,
    "shiftType" TEXT NOT NULL DEFAULT 'DAY',
    "profileImage" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "User_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Attendance" (
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "date" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "shiftType" TEXT NOT NULL DEFAULT 'DAY',
    "amIn" TIMESTAMP(3),
    "amOut" TIMESTAMP(3),
    "pmIn" TIMESTAMP(3),
    "pmOut" TIMESTAMP(3),
    "nightIn" TIMESTAMP(3),
    "nightOut" TIMESTAMP(3),
    "amInPhoto" TEXT,
    "amOutPhoto" TEXT,
    "pmInPhoto" TEXT,
    "pmOutPhoto" TEXT,
    "nightInPhoto" TEXT,
    "nightOutPhoto" TEXT,
    "status" TEXT NOT NULL DEFAULT 'ABSENT',
    "workHours" DOUBLE PRECISION,
    "notes" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Attendance_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Settings" (
    "id" TEXT NOT NULL,
    "amStartTime" TEXT NOT NULL DEFAULT '08:00',
    "amEndTime" TEXT NOT NULL DEFAULT '12:00',
    "pmStartTime" TEXT NOT NULL DEFAULT '13:00',
    "pmEndTime" TEXT NOT NULL DEFAULT '17:00',
    "nightStartTime" TEXT NOT NULL DEFAULT '22:00',
    "nightEndTime" TEXT NOT NULL DEFAULT '06:00',
    "amGracePeriod" INTEGER NOT NULL DEFAULT 15,
    "pmGracePeriod" INTEGER NOT NULL DEFAULT 15,
    "nightGracePeriod" INTEGER NOT NULL DEFAULT 15,
    "lateThreshold" INTEGER NOT NULL DEFAULT 15,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Settings_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ActivityLog" (
    "id" TEXT NOT NULL,
    "userId" TEXT,
    "userName" TEXT,
    "action" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "type" TEXT NOT NULL DEFAULT 'INFO',
    "metadata" TEXT,
    "scanPhoto" TEXT,
    "ipAddress" TEXT,
    "userAgent" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "ActivityLog_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "FileUpload" (
    "id" TEXT NOT NULL,
    "data" BYTEA NOT NULL,
    "mimeType" TEXT,
    "filename" TEXT,

    CONSTRAINT "FileUpload_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");

-- CreateIndex
CREATE INDEX "Attendance_userId_idx" ON "Attendance"("userId");

-- CreateIndex
CREATE INDEX "Attendance_date_idx" ON "Attendance"("date");

-- CreateIndex
CREATE INDEX "Attendance_shiftType_idx" ON "Attendance"("shiftType");

-- CreateIndex
CREATE UNIQUE INDEX "Attendance_userId_date_shiftType_key" ON "Attendance"("userId", "date", "shiftType");

-- CreateIndex
CREATE INDEX "ActivityLog_userId_idx" ON "ActivityLog"("userId");

-- CreateIndex
CREATE INDEX "ActivityLog_action_idx" ON "ActivityLog"("action");

-- CreateIndex
CREATE INDEX "ActivityLog_createdAt_idx" ON "ActivityLog"("createdAt");

-- CreateIndex
CREATE INDEX "ActivityLog_type_idx" ON "ActivityLog"("type");

-- AddForeignKey
ALTER TABLE "Attendance" ADD CONSTRAINT "Attendance_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;
