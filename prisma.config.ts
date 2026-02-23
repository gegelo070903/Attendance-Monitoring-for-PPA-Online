import { defineConfig } from '@prisma/cli';

export default defineConfig({
  datasource: {
    adapter: process.env.DATABASE_URL,
  },
});
