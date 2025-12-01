import { defineConfig } from '@vinxi/app'

 export default defineConfig({
   server: {
     // Tell Vinxi where to find the server entry point
     entry: './frontend/entry-server.tsx'
   },
   client: {
     // Tell Vinxi where to find the client entry point
     entry: './frontend/entry-client.tsx'
   },
   // You can also customize other settings here
   router: {
     basePath: '/'
   }
 })
